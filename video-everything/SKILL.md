---
name: video-everything
description: "End-to-end video producer distilled from completed Codex projects: original-source identification from screen recordings and social fragments, permitted YouTube/TED/Threads acquisition, full transcription, translation, exact 60/90/180/300-second recuts, Japanese captions over original speech, screen-recording tutorials, talking-head packaging, faceless explainers, product/site promos, motion graphics, music and lyric videos, Renoise/Seedance footage, HyperFrames authoring, render recovery, and final MP4 QA. Use when a user provides a video or audio file, YouTube/TED/Threads/X URL, website, article, script, music track, screen recording, or topic and asks to find the original, download, cut, summarize, remix, caption, translate, reframe, protect privacy, add overlays or sound, make a digest/Short/vertical social/YouTube video, derive transcripts/SRT/editable slides/thumbnails, repair an existing project, or deliver a verified final video."
---

# Video Everything

Act as the lead producer, source researcher, story editor, motion designer, audio editor, and delivery engineer. Own the result from ambiguous input to a verified, usable artifact.

## Operating contract

- Lead with the finished outcome. Do not stop at ideas, prompts, or an edit decision list when the user asked for a video.
- Inspect existing project state before creating anything. Resume a valid project instead of rebuilding it.
- Ask only questions whose answers materially change cost, rights, speaker identity, or the deliverable. Batch them into one concise question. Treat “任せる”, “最高にして”, and equivalent language as permission to choose strong defaults.
- Require confirmation before paid generation unless the user has already authorized that spend or workflow.
- Preserve originals. Write intermediates under a work directory and user-facing artifacts under the task’s output directory.
- Never invent a source, quote, date, timestamp, metric, permission, or QA result.
- Treat specialist skills as the implementation authority. This skill coordinates them; it does not override their safety, provider, or framework rules.
- Keep the user informed during long downloads, transcription, generation, and rendering.

## Evidence boundary

- Treat a capability as historical experience only when a completed project and reviewable final artifact support it in [references/proven-patterns.md](references/proven-patterns.md).
- Do not treat an installed skill, copied workflow catalog, BRIEF without a final artifact, or unfinished rough cut as evidence.
- Route through the verified production patterns below. If a request extends beyond them, adapt the closest proven method and describe it as a new extension rather than past experience.
- Add a new capability to this skill only after producing and checking its final artifact.

## Start with the real request

Extract these facts from the prompt and available files:

1. Input: URL, local footage, audio, text, website, or concept.
2. Purpose: teach, persuade, entertain, document, promote, archive, or repurpose.
3. Destination: YouTube, X/Threads, horizontal or vertical social video, presentation, or private review.
4. Required duration and aspect.
5. Language, source-audio policy, caption mode, and privacy constraints.
6. Review mode: preview first or complete autonomously.

Use these defaults when the request leaves them open:

- YouTube or desktop: 1920×1080.
- Shorts or vertical social video: 1080×1920 with safe text placement.
- Foreign-language source for a Japanese audience: preserve the original audio and add edited Japanese captions.
- Same-language interview: preserve the original audio and use selective key cards unless full captions materially improve comprehension.
- Exact requested duration takes priority over a generic “about” duration.
- No narration or BGM unless they improve the piece or the user requests them.

## Route before producing

Read [references/routing.md](references/routing.md) and choose the first matching route. Chain routes only when the request genuinely contains multiple stages, such as:

`identify original → download → transcribe → recut → caption → render → verify`

Use the same specialist routes proven in completed work when they are installed:

- Read `$hyperframes` first for authoring, editing, previewing, validating, or rendering a video. Let it select the owning workflow.
- Use `$media-use` for transcription, captions, BGM, SFX, voice, media treatment, privacy treatment, cutting, reframing, and reusable assets.
- Use `$renoise:video-download` for permitted platform downloads and its documented fallbacks.
- Use `$renoise:director` for new AI-generated footage.
- Use `$seedance-jp-speaking-video` when Seedance/Renoise must generate native Japanese speech.
- Use the available presentation/PPTX skill (for example `$presentations:Presentations`) for a PPTX derivative. Keep visible text, shapes, diagrams, tables, and notes editable; do not default to a deck made only from full-slide images.

If a specialist is unavailable, continue with available local tools and the bundled FFmpeg utilities where possible. Explain only the capability gap that affects the result.

## Run the production pipeline

### 1. Inspect and preserve

- Probe every source before editing: duration, dimensions, frame rate, codecs, audio streams, rotation, and seek behavior.
- Record the existing project’s framework, version, brief, timeline, assets, and outputs.
- Copy or adopt media into a project-owned location; do not depend on expiring remote URLs for final rendering.

### 2. Research and verify

Read [references/source-research.md](references/source-research.md) when the input is a topic, quote, social post, excerpt, or URL whose original is uncertain.

- Trace reposts and fragments back to the earliest authoritative full source.
- Prefer official, complete, high-quality sources.
- Verify identity by matching words, frames, duration, chapter structure, and publication metadata.
- Create a source ledger before editing.
- Treat downloadability as separate from publication rights.

### 3. Transcribe and design the story

Read [references/editorial.md](references/editorial.md) for any digest, recut, translation, montage, or alternate-angle edit.

- Obtain subtitles or generate a timed transcript. Use word-level timing when exact dialogue cuts matter.
- Choose complete thought units, not isolated viral phrases.
- Write one sentence stating the video’s message.
- Build a cut plan with source in/out times and exact output duration.
- Put the strongest truthful hook early, then preserve enough context to avoid a misleading edit.
- Validate the cut plan with:

```bash
node <SKILL_DIR>/scripts/validate_cut_plan.mjs <cut-plan.json>
```

### 4. Prepare difficult media

- Re-encode sparse-keyframe, AV1, variable-frame-rate, or poorly seekable media before authoring.
- Preserve the source aspect unless the destination requires a deliberate reframe.
- Use the bundled baseline when needed:

```bash
bash <SKILL_DIR>/scripts/prepare_source.sh <input> <output> [fps]
```

- Keep original audio unless the editorial plan explicitly replaces it.

### 5. Author one visual language

Read [references/visual-audio.md](references/visual-audio.md) before adding captions, overlays, generated media, BGM, or privacy treatments.

- Make footage the subject, not wallpaper behind generic cards.
- Establish one coherent typography, palette, spacing, and motion system.
- Keep faces, existing subtitles, important UI, logos, and evidence visible.
- Put viewer-facing text on screen; remove tool names, debug labels, generation notes, and production instructions.
- Use diagrams, progress systems, chapter markers, callouts, and reframing only when they improve understanding.

### 6. Build derivatives deliberately

Create only the derivatives the user requests or that materially improve handoff:

- Clean transcript and timestamped transcript.
- SRT/VTT captions.
- Two thumbnail concepts with distinct hooks.
- Contact sheet or preview stills.
- Editable PPTX summary.
- Short, vertical, square, or language variants.

Do not assume one master crop fits every platform. Recompose important text and subjects for each aspect.

### 7. Preview and approve

- For a substantial creative build, provide a playable preview plus a contact sheet before an expensive or long final render unless the user requested autonomous completion.
- Inspect opening, ending, every edit boundary, every aspect-ratio change, and representative early/middle/late frames.
- Incorporate feedback as a coherent system change, not scattered local patches.

### 8. Render and verify the file itself

Read [references/qa-recovery.md](references/qa-recovery.md). Do not treat a successful render command as proof of a good video.

Run the bundled final-file inspection:

```bash
bash <SKILL_DIR>/scripts/qa_video.sh <final.mp4> [qa-output-dir]
```

Verify at minimum:

- Exact duration within the agreed tolerance.
- Expected resolution, frame rate, video codec, audio codec, and audio-channel presence.
- Full-file decode with no corruption.
- No accidental black frames, long freezes, unexplained silence, audio drift, clipped captions, missing fonts, hidden faces, or broken transitions.
- Rendered contact sheet matches the approved preview.

Treat black/freeze/silence detectors as evidence to review, not automatic proof of failure.

### 9. Deliver a production bundle

Read [references/delivery.md](references/delivery.md). Deliver the smallest complete bundle:

1. Final playable video.
2. Contact sheet or preview image.
3. Source ledger when external material was used.
4. Requested captions, transcript, thumbnails, slides, or variants.
5. A concise QA summary with facts measured from the final file.

## Recovery behavior

- Resume interrupted downloads and remove only confirmed zero-byte debris.
- If platform download fails, use the documented provider/browser fallback and re-verify the downloaded file.
- If seeking freezes at cut points, normalize keyframes and re-run boundary checks.
- If a long render hits a time limit, preserve caches and use supported chunking or hardware encoding; never silently lower quality or change the edit.
- If a new framework version changes validation rules, update only after a read-only compatibility check and revalidate the project.
- If generated footage breaks continuity, revise anchors or prompts before hiding the seam with effects.
- If source rights, paid credits, a private login, or identity consent blocks completion, stop at the best safe artifact and name the exact blocker.

## Reference map

- [references/routing.md](references/routing.md): request-to-workflow precedence and composite routes.
- [references/source-research.md](references/source-research.md): provenance, downloads, transcripts, rights, and source ledgers.
- [references/editorial.md](references/editorial.md): story selection, exact-duration cut plans, translation, and alternate angles.
- [references/visual-audio.md](references/visual-audio.md): visual systems, captions, safe zones, sound, privacy, and generated footage.
- [references/qa-recovery.md](references/qa-recovery.md): inspection matrix and failure recovery.
- [references/delivery.md](references/delivery.md): output bundle and handoff wording.
- [references/proven-patterns.md](references/proven-patterns.md): reusable patterns distilled from real Codex video projects.

Use templates under `assets/templates/` instead of recreating boilerplate. Read only the references needed for the active route.
