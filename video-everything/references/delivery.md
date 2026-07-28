# Delivery

Deliver the smallest complete production bundle.

## Recommended structure

```text
outputs/
├── project-final.mp4
├── project-contact-sheet.jpg
├── project-sources.md
├── project.srt                 # when requested
├── project-transcript.txt      # when requested
├── project-thumbnail-a.png     # when requested
├── project-thumbnail-b.png     # when requested
└── project-summary.pptx        # when requested
```

Do not expose cache directories, partial downloads, temporary frames, credentials, or provider payloads.

## Final response

Lead with the final video link. Then state only verified facts:

- Duration.
- Resolution and frame rate.
- Video/audio codecs.
- Source-audio or generated-audio policy.
- Caption language/mode.
- Key QA result.
- Links to requested derivatives.

Example:

> 完成しました。  
> [最終MP4](/absolute/output/project-final.mp4)  
> 3:00 exactly, 1920×1080/30fps, H.264 + AAC. Original English audio with edited Japanese captions. Full decode and edit-boundary checks passed.

Do not say “perfect”, “copyright-safe”, “licensed”, or “all checks passed” unless the evidence supports the exact claim.

## Preview handoff

When approval is required:

- Link the playable preview.
- Show a contact sheet.
- Summarize the editorial thesis, duration, audio, and caption choices.
- Ask for one clear approval action.
- Do not render a costly final before the required approval.

## Source handoff

Include a source ledger when external material was used. Cite official sources near the relevant claim in the chat response. State any publication-rights caveat without turning the whole handoff into legal advice.

## Editable slide derivative

- Use editable text boxes, shapes, diagrams, tables, and speaker notes.
- Keep source citations in notes or a source slide.
- Render or preview every slide before delivery.
- Do not build an image-only PPTX unless the user explicitly requests it and acknowledges that text will not be editable.

## Variant delivery

Name variants by purpose, not “v2/final-final”:

- `project-youtube-16x9.mp4`
- `project-shorts-9x16.mp4`
- `project-ja-captions.mp4`
- `project-clean.mp4`

Revalidate each variant. A successful master does not prove a reframe or caption variant is safe.

## Cleanup

- Preserve source and project files unless the user requests cleanup.
- Move rejected but sensitive captures to a recoverable trash location when practical.
- Remove only known temporary files created by the workflow.
- Report any material deletion and whether recovery is possible.
