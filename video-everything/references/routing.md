# Routing

Use this file to choose an owning workflow. Route from the requested deliverable, not from a tool name mentioned in passing.

Every route below is backed by a completed project named in
[proven-patterns.md](proven-patterns.md). Do not add a route merely because its
skill is installed.

## Precedence

Apply the first matching rule.

1. **Existing project, specific operation**  
   Resume the project and perform only the requested inspect, diagnose, edit, preview, render, publish, or repair operation.

2. **Source identification or download only**  
   Use source research plus `$renoise:video-download`. Do not start an edit unless requested.

3. **AI-generated-footage request**  
   Use `$seedance-jp-speaking-video` for native Japanese Seedance speech and `$renoise:director` for other new AI-generated footage when available. Use HyperFrames afterward only when editing, compositing, captions, audio, or delivery is requested.

4. **Record a browser/app workflow only**  
   Use the available browser/computer recording capability. Do not route to HyperFrames unless packaging or editing the recording is also requested.

5. **Editable PPTX derivative**  
   Use the presentation workflow after the video transcript and editorial summary are fixed.

6. **Captions or translated captions over existing footage**  
   Route through HyperFrames to `general-video`, preserving the source footage and audio unless the request also requires a recut.

7. **Designed overlays on an unchanged talk/interview**  
   Route through HyperFrames to `talking-head-recut`.

8. **Beat-driven music, lyric video, or visualizer**  
   Route through HyperFrames to `music-to-video`.

9. **Short unnarrated motion unit, usually under 10 seconds**  
   Route through HyperFrames to `motion-graphics`.

10. **Website/product promo or site tour**  
    Route through HyperFrames to `product-launch-video`.

11. **Topic/article/notes explained with invented visuals and no featured product**  
    Route through HyperFrames to `faceless-explainer`.

12. **Digest, recut, montage, screen tutorial packaging, multi-source edit, generated-footage finish, or any other custom video**  
    Route through HyperFrames to `general-video`.

## Composite routes

Run stages in this order when the request combines them:

| Request | Route |
| --- | --- |
| “What is this Threads clip? Make a five-minute digest.” | identify → verify original → download permitted source → transcribe → general-video recut → QA |
| “Find a recent TED talk and make a Japanese three-minute version.” | current web research → official-source verification → download → subtitle/transcript → editorial plan → general-video → Japanese captions → QA |
| “Turn this screen recording into a tutorial with BGM.” | probe → privacy scan → story edit → general-video → media-use BGM → QA |
| “Make this person speak Japanese with Seedance and add captions.” | reference-image preparation → seedance-jp-speaking-video → preserve generated speech → HyperFrames finish → QA |
| “Create a cinematic 30-second AI film.” | Renoise director → generation approval → continuity generation → HyperFrames finish → QA |
| “Download this interview and add captions only.” | download → general-video caption treatment → QA |
| “Make six three-minute videos from these sources.” | source verification → per-video cut plans → shared visual system → batch authoring/render → per-file QA |
| “Create a music video from this track.” | audio analysis → music-to-video → beat-synced authoring → loudness/codec QA |
| “Make a summary deck from the finished video.” | final transcript → editorial summary → editable PPTX; keep text and diagrams editable |

## Intent defaults

Use strong defaults instead of interrogating the user:

| Signal | Default |
| --- | --- |
| “ダイジェスト” with no length | Recommend 3 minutes for a teaching/explainer source; use 60–90 seconds for one focused claim |
| “切り抜き” | Preserve original voice, select complete statements, add only helpful context graphics |
| “Shorts / 縦型SNS” | 9:16, concise hook in the first two seconds, safe text zone, captions on |
| “YouTube” | 16:9, 1080p, chaptered story for pieces over about 90 seconds |
| Foreign speech for Japanese audience | Original audio plus edited Japanese captions |
| “顔なし” | Recompose or use a meaningful privacy treatment; do not cover the face with an arbitrary blob |
| “最新” or “探して” | Browse and verify publication date and source |
| “任せる / 最高に” | Choose one strong concept and produce it; do not return a menu of undeveloped ideas |
| Existing successful master, new angle | Reuse source and visual system but select non-overlapping evidence and a new thesis |

## Cost and approval

- Local research, transcription, FFmpeg operations, HyperFrames authoring, and validation may proceed within the user’s request.
- Before paid AI generation, check balance or estimated usage and obtain confirmation unless already authorized.
- Before publishing, uploading, sending, or posting externally, require explicit user authorization.
- A local final render does not require extra confirmation when the user explicitly asked for a finished file and no underlying workflow requires a preview gate.

## Missing capability behavior

1. Check the current skill/tool catalog.
2. Use an available equivalent only when it preserves the requested provider, audio policy, and output contract.
3. Never silently replace native Seedance speech with TTS or replace a named video model.
4. If a missing connector affects only research convenience, continue with web and local tools.
5. If it prevents the requested result, stop at the best safe intermediate and state the exact missing dependency.
