# QA and Recovery

Validate the rendered artifact, not only the source code or preview.

## Four-stage inspection

### 1. Source gate

- Probe every input.
- Confirm all intended streams exist.
- Check duration and start time.
- Inspect rotation, pixel format, HDR/SDR, variable frame rate, and sparse keyframes.
- Confirm downloaded files are complete and locally stable.

### 2. Authoring gate

- Run the framework’s lint/check command.
- Check runtime, layout, motion, and contrast.
- Inspect longest captions and every variable value.
- Test direct seeking into every scene.
- Verify fonts are embedded or resolvable.

### 3. Preview gate

Inspect:

- Opening and ending.
- Every edit boundary.
- Every source switch.
- Every audio start/end.
- Early, middle, and late representative frames.
- Fast caption sequences.
- Privacy masks across time.

Use a contact sheet plus individual boundary frames. A contact sheet alone can miss a one-frame flash.

### 4. Final-file gate

Run:

```bash
bash <SKILL_DIR>/scripts/qa_video.sh final.mp4 qa/final
```

Then review:

- `report.md`
- `probe.json`
- `decode-errors.log`
- `blackdetect.log`
- `freezedetect.log`
- `silencedetect.log`
- `volumedetect.log`
- `contact-sheet.jpg`

Required measured facts:

- File size.
- Container duration.
- Video duration, dimensions, pixel format, codec, nominal/average frame rate.
- Audio codec, sample rate, channels, and duration when audio is expected.
- Full decode result.

## Signal interpretation

- **Black detect:** expected for intentional fades; suspicious at the start, source switches, or long spans.
- **Freeze detect:** expected for designed hold frames; suspicious over live speech or moving interview footage.
- **Silence detect:** expected in deliberate endings; suspicious inside continuous speech or music.
- **Frame-count mismatch:** inspect time base and variable-frame-rate conversion.
- **Audio/video duration mismatch:** verify muxing and tail padding.

Do not claim “no freezes” merely because the detector log is empty if only a partial scan ran.

## Common recovery

| Failure | Recovery |
| --- | --- |
| Download stopped at a size cap | Resume or select an adequate lower-resolution official format; verify file afterward |
| Zero-byte `.part` or output | Confirm it is unusable, remove only that debris, and resume |
| Clip freezes after seeking | Re-encode with one-second or shorter keyframe spacing using `prepare_source.sh` |
| AV1 source makes checks very slow | Create an H.264 editing proxy/master while preserving the original |
| Subtitle font changes in render | Resolve and freeze the font locally; recheck representative frames |
| Caption briefly fails contrast | Inspect entrance frames and reduce travel or add a supported treatment |
| Scene is black inside a subcomposition | Move framework-owned media to the correct parent track and keep overlays in the subcomposition |
| Long render exceeds CLI limit | Preserve supported cache, use official chunking/hardware encoding, then validate the assembled file |
| Generated shots do not join | Adjust identity/location/tail-frame/ref-video anchors and regenerate the weak shot |
| Native generated audio is absent | Re-prompt or regenerate; ask before substituting TTS |
| Browser/social extraction fails | Use the documented authenticated-browser fallback and re-verify provenance |

## Exact-duration tolerance

- For fixed-frame output, use one frame as the default tolerance.
- For a 30 fps target, one frame is about 0.0333 seconds.
- Measure the final muxed file, not only the timeline declaration.
- If container and stream durations differ, investigate before declaring success.

## Visual sign-off

Reject or revise a render with:

- Accidental black/blank frames.
- Clipped or off-screen text.
- Tiny unreadable UI.
- Overlays hiding the subject or evidence.
- Wrong font or missing glyphs.
- Unexplained color/brightness jumps.
- Frozen live footage.
- Visible private information.
- Broken generated faces/hands/lip sync at important moments.
- A preview/final mismatch.
