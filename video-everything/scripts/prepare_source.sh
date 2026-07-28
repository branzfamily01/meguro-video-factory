#!/usr/bin/env bash
set -euo pipefail

input_path="${1:-}"
output_path="${2:-}"
target_fps="${3:-30}"

if [[ -z "$input_path" || -z "$output_path" ]]; then
  printf 'Usage: prepare_source.sh <input> <output.mp4> [fps]\n' >&2
  exit 2
fi

if [[ ! -f "$input_path" ]]; then
  printf 'Input does not exist: %s\n' "$input_path" >&2
  exit 2
fi

if [[ "$input_path" == "$output_path" ]]; then
  printf 'Input and output must be different files.\n' >&2
  exit 2
fi

if [[ ! "$target_fps" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  printf 'FPS must be a positive number: %s\n' "$target_fps" >&2
  exit 2
fi

for dependency in ffmpeg ffprobe; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'Missing dependency: %s\n' "$dependency" >&2
    exit 2
  fi
done

gop_size="$(awk -v fps="$target_fps" 'BEGIN { value = int(fps + 0.5); if (value < 1) value = 1; print value }')"
output_dir="$(dirname "$output_path")"
mkdir -p "$output_dir"

audio_codec="$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_path" | head -n 1 || true)"
audio_args=(-an)
if [[ -n "$audio_codec" ]]; then
  audio_args=(-map '0:a?' -c:a aac -b:a 192k -ar 48000)
fi

ffmpeg -y \
  -i "$input_path" \
  -map 0:v:0 \
  "${audio_args[@]}" \
  -vf "fps=${target_fps}" \
  -c:v libx264 \
  -preset medium \
  -crf 18 \
  -pix_fmt yuv420p \
  -g "$gop_size" \
  -keyint_min "$gop_size" \
  -sc_threshold 0 \
  -movflags +faststart \
  "$output_path"

ffprobe -v error \
  -show_entries format=duration,size \
  -show_entries stream=index,codec_type,codec_name,width,height,r_frame_rate,sample_rate,channels \
  -of json \
  "$output_path"

printf 'Prepared seek-safe source: %s\n' "$output_path"
