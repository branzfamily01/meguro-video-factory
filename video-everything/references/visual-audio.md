# Visual and Audio Direction

## One visual language

Define one system for the whole piece:

- One primary type family, with a second family only for a clear functional contrast.
- A restrained palette derived from the source, brand, or concept.
- A spacing and alignment grid.
- A repeatable hierarchy for title, chapter, caption, source, and CTA.
- A small motion vocabulary tied to the story’s rhythm.

Avoid the default “dashboard of rounded cards” look unless the subject is genuinely a dashboard. Use the source’s world: documentary, editorial, research notebook, broadcast, cinema, product UI, or music performance.

## Keep the evidence visible

- Do not cover a speaker’s face, mouth, hands, an existing subtitle, a logo needed for provenance, or important screen UI.
- Place overlays in measured empty space.
- Move or shorten the graphic when the subject changes position.
- If the source already contains useful subtitles, add chapter context rather than duplicate captions.
- Use picture-in-picture only when two views must be compared simultaneously.

## Viewer-facing text only

Remove production notes such as:

- Tool, model, or framework names.
- “white bold captions”, “no background”, “TTS off”, debug, draft, sample, credits, or validation labels.
- Prompt fragments or internal scene IDs.

Keep only titles, explanations, evidence, subtitles, source credit, brand copy, and CTA intended for the audience.

## Platform composition

### 16:9

- Preserve the source’s natural frame when possible.
- Use side or lower-third zones for context.
- Keep small screen UI large enough to read at ordinary playback size.

### 9:16

- Recompose; do not merely center-crop a horizontal master.
- Keep primary captions above the platform’s lower caption/navigation area.
- Leave extra clearance on the right for action buttons.
- For 1080×1920, use a conservative main-caption lower edge around `y=1220`; avoid extending below roughly `y=1320` without a platform-specific reason.
- Keep CTA out of the bottom UI region.

## Caption design

- Use high contrast, tested against actual moving frames.
- Keep Japanese lines short enough to read at speech speed.
- Avoid more than two lines except for a deliberate quotation card.
- Place punctuation and line breaks by meaning.
- Use subtle shadow or stroke when the background moves; avoid oversized opaque boxes by default.
- Check every caption at its longest content and at entrance/exit frames.

## Motion

- Animate hierarchy and causality, not every object.
- Make entries seek-safe and deterministic.
- Use one dominant transition idea per section.
- Avoid ambient perpetual motion that competes with speech.
- Match hard cuts, dips, wipes, or continuous camera motion to the source and story.
- Do not hide a broken generated-video seam with effects until continuity anchors and prompt design have been corrected.

## Faces and privacy

- Use the canonical privacy/media treatment from `$media-use` when available.
- For “faceless” packaging, reframe, crop, replace the face region with meaningful process information, or use a supported blur/pixelation treatment.
- Inspect early, middle, and late frames to ensure the face never escapes the mask.
- Do not expose unrelated task names, tabs, notifications, personal data, or credentials in screen recordings.

## Original audio

Preserve original speech when it is the evidence. Keep dialogue intelligible before adding music or effects.

- Do not replace native Seedance/Renoise Japanese speech with TTS unless the user approves.
- Separate generated video and generated audio for editing when needed, but keep the native audio content.
- Avoid abrupt cuts inside consonants or breaths.
- Use short fades only when they do not blur speech.

## BGM and SFX

- Add BGM when the piece benefits from pacing or emotional continuity, not because every video “needs music.”
- Use one coherent bed for a short piece.
- Keep dialogue dominant; start low and inspect the actual mix.
- Duck or reduce music under dense speech.
- Use transition SFX sparingly and only at meaningful structural beats.
- Confirm licensing or provider usage terms for public delivery.
- Record chosen audio in the source/media ledger.

## Generated footage

- Use one main action and one camera move per short shot.
- Maintain recurring characters with registered assets or provider-supported identity anchors.
- Use a previous tail frame for an exact next opening state.
- Use reference video for motion or style continuation.
- Inspect generated speech, lip sync, hands, text artifacts, brand marks, and continuity before authoring.
- Do not present generated reenactments as documentary footage.

## Thumbnails

Create variants with genuinely different hooks:

- A: human/subject-driven emotion or claim.
- B: result, contrast, or mechanism.

Keep text minimal, use the real subject or approved generated art, and verify at small display size.
