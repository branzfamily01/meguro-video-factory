#!/usr/bin/env bash
set -euo pipefail

input_path="${1:-}"
qa_dir="${2:-}"

if [[ -z "$input_path" ]]; then
  printf 'Usage: qa_video.sh <input.mp4> [qa-output-dir]\n' >&2
  exit 2
fi

if [[ ! -f "$input_path" ]]; then
  printf 'Input does not exist: %s\n' "$input_path" >&2
  exit 2
fi

for dependency in ffmpeg ffprobe awk; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'Missing dependency: %s\n' "$dependency" >&2
    exit 2
  fi
done

if [[ -z "$qa_dir" ]]; then
  qa_dir="${input_path%.*}-qa"
fi
mkdir -p "$qa_dir"

probe_json="$qa_dir/probe.json"
decode_log="$qa_dir/decode-errors.log"
black_log="$qa_dir/blackdetect.log"
freeze_log="$qa_dir/freezedetect.log"
silence_log="$qa_dir/silencedetect.log"
loudness_log="$qa_dir/volumedetect.log"
contact_sheet="$qa_dir/contact-sheet.jpg"
report_path="$qa_dir/report.md"

ffprobe -v error \
  -show_entries format=filename,format_name,duration,size,bit_rate \
  -show_entries stream=index,codec_type,codec_name,profile,width,height,pix_fmt,r_frame_rate,avg_frame_rate,duration,sample_rate,channels,channel_layout \
  -of json \
  "$input_path" > "$probe_json"

format_duration="$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1)"
format_size="$(ffprobe -v error -show_entries format=size -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1)"
video_codec="$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1)"
video_dimensions="$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$input_path" | head -n 1)"
video_fps="$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1)"
audio_codec="$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1 || true)"
audio_rate="$(ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1 || true)"
audio_channels="$(ffprobe -v error -select_streams a:0 -show_entries stream=channels -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1 || true)"

decode_status=0
if ffmpeg -v error -xerror -i "$input_path" -map '0:v?' -map '0:a?' -f null - 2> "$decode_log"; then
  decode_status=0
else
  decode_status=$?
fi

ffmpeg -hide_banner -nostats -i "$input_path" \
  -map 0:v:0 -vf 'blackdetect=d=0.5:pix_th=0.10' -an -f null - 2>&1 \
  | grep -E 'black_(start|end|duration)' > "$black_log" || true

ffmpeg -hide_banner -nostats -i "$input_path" \
  -map 0:v:0 -vf 'freezedetect=n=-60dB:d=2' -an -f null - 2>&1 \
  | grep -E 'freeze_(start|end|duration)' > "$freeze_log" || true

if [[ -n "$audio_codec" ]]; then
  ffmpeg -hide_banner -nostats -i "$input_path" \
    -map 0:a:0 -af 'silencedetect=n=-50dB:d=1' -vn -f null - 2>&1 \
    | grep -E 'silence_(start|end|duration)' > "$silence_log" || true
  ffmpeg -hide_banner -nostats -i "$input_path" \
    -map 0:a:0 -af 'volumedetect' -vn -f null - 2>&1 \
    | grep -E '(mean_volume|max_volume):' > "$loudness_log" || true
else
  printf 'No audio stream detected.\n' > "$silence_log"
  printf 'No audio stream detected.\n' > "$loudness_log"
fi

if [[ -n "$video_codec" && -n "$format_duration" ]]; then
  sample_interval="$(awk -v duration="$format_duration" 'BEGIN { value = duration / 12; if (value < 0.1) value = 0.1; printf "%.6f", value }')"
  ffmpeg -y -hide_banner -loglevel error \
    -i "$input_path" \
    -vf "fps=1/${sample_interval},scale=480:-2,tile=4x3:padding=8:margin=8:color=0x111111" \
    -frames:v 1 \
    "$contact_sheet"
fi

black_events="$(wc -l < "$black_log" | tr -d ' ')"
freeze_events="$(wc -l < "$freeze_log" | tr -d ' ')"
silence_events="$(grep -c 'silence_' "$silence_log" || true)"
silence_duration="$(awk '
  /silence_duration:/ {
    for (field = 1; field <= NF; field += 1) {
      if ($field == "silence_duration:") total += $(field + 1)
    }
  }
  END { printf "%.3f", total + 0 }
' "$silence_log")"
silence_coverage="$(awk -v silent="$silence_duration" -v duration="${format_duration:-0}" '
  BEGIN {
    if (duration > 0) printf "%.1f", (silent / duration) * 100
    else printf "0.0"
  }
')"
mean_volume="$(awk -F': ' '/mean_volume:/ { value = $2 } END { print value }' "$loudness_log")"
max_volume="$(awk -F': ' '/max_volume:/ { value = $2 } END { print value }' "$loudness_log")"
max_volume_number="$(awk -F': ' '
  /max_volume:/ {
    split($2, parts, " ")
    value = parts[1]
  }
  END { if (value != "") print value }
' "$loudness_log")"

audio_result="PRESENT"
if [[ -z "$audio_codec" ]]; then
  audio_result="MISSING"
elif awk -v coverage="$silence_coverage" 'BEGIN { exit !(coverage >= 95) }'; then
  audio_result="REVIEW — detected silence covers at least 95% of the file"
elif [[ -n "$max_volume_number" ]] && awk -v peak="$max_volume_number" 'BEGIN { exit !(peak <= -50) }'; then
  audio_result="REVIEW — audio peak is at or below -50 dB"
fi

decode_result="PASS"
if [[ "$decode_status" -ne 0 || -s "$decode_log" ]]; then
  decode_result="REVIEW"
fi

cat > "$report_path" <<EOF
# Video QA report

- File: \`$input_path\`
- Container duration: ${format_duration:-unknown} s
- File size: ${format_size:-unknown} bytes
- Video: ${video_codec:-missing}, ${video_dimensions:-unknown}, average frame rate ${video_fps:-unknown}
- Audio: ${audio_codec:-missing}, ${audio_rate:-unknown} Hz, ${audio_channels:-unknown} channel(s)
- Audio review: $audio_result
- Audio level: mean ${mean_volume:-unknown}, max ${max_volume:-unknown}
- Full decode: $decode_result
- Black-detect log lines: $black_events
- Freeze-detect log lines: $freeze_events
- Silence events: $silence_events; detected silence ${silence_duration}s (${silence_coverage}% of container duration)

## Review

- Treat detector events as review signals; intentional fades, holds, and silence may be valid.
- Inspect \`contact-sheet.jpg\`, every edit boundary, the opening, and the ending.
- Confirm the measured duration and streams against the project contract.
EOF

printf 'QA report: %s\n' "$report_path"
if [[ -f "$contact_sheet" ]]; then
  printf 'Contact sheet: %s\n' "$contact_sheet"
fi

if [[ "$decode_result" != "PASS" || -z "$video_codec" ]]; then
  exit 1
fi
