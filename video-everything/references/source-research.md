# Source Research and Provenance

Use this file when the user provides a quote, short social clip, screenshot, topic, or uncertain URL.

Evidence anchors: `elon-forbes-2031` traced a screen recording to the official
Forbes interview; `nishino-generation-digest` joined an official full program
with the verified Threads excerpt that preserved omitted generations.

## Provenance ladder

Prefer sources in this order:

1. Original publisher, speaker, event, production company, or official channel.
2. Official full-length repost or licensed distributor.
3. Credible publication embedding the original.
4. A repost only when no authoritative source exists.

Do not choose a repost merely because it is easier to download.

## Trace a fragment to the original

1. Inspect visible and audible clues:
   - Speaker, host, set, watermark, lower-third, logo, subtitle style.
   - Exact unusual phrase from the clip.
   - Approximate publication period and event.
   - Aspect, duration, and any platform-specific crop.
2. Transcribe a distinctive 8–20 word phrase.
3. Search the exact phrase with likely speaker/show/channel names.
4. Compare candidate frames, spoken wording, background, duration, and chapter order.
5. Open the strongest candidate and confirm the fragment’s exact timestamp.
6. Check whether the candidate is a full version, an official excerpt, or another repost.
7. Record confidence and any correction to the user’s premise.

Example: a post described as “Sam Altman’s first interview” may actually be the interviewer’s first interview with Altman. Correct the wording when the source supports that distinction.

## Research a topic

When the user asks to “find a recent video”:

- Browse current results; do not rely on memory for dates or availability.
- Prefer primary videos and official channels.
- Verify the publication date on the source page.
- Evaluate whether the video contains enough coherent material for the requested duration.
- Prefer one source with a complete argument over a collage of weak sources.
- Use multiple sources when they play distinct roles or fill a documented gap.

## Download and freeze sources

Use `$renoise:video-download` when available. Otherwise use a documented, permitted downloader.

After download:

1. Remove only confirmed zero-byte or corrupt partials.
2. Probe the file with `ffprobe`.
3. Confirm duration, video stream, audio stream, dimensions, frame rate, and codec.
4. Save platform metadata and available subtitle tracks.
5. Store the media in a project-owned directory.
6. Avoid rendering from expiring CDN or signed URLs.

If a file exceeds a downloader’s size cap, select a fit-for-purpose official format rather than abandoning the source. For ordinary 1080p delivery, a clean 720p/1080p master is often preferable to an impractical 4K source.

## Transcript sources

Use the best available timing source:

1. Official human captions.
2. Official or platform auto-captions, inspected for errors.
3. Local speech-to-text.
4. Manual correction around all chosen cut boundaries.

Use word-level timestamps when:

- The final duration must be exact.
- Sentences are being reordered.
- Captions must follow fast speech.
- A cut must land between words or breaths.

## Source ledger

Copy `assets/templates/source-ledger.md` and record one row per source.

Required fields:

- Source ID.
- Original title.
- Publisher/channel.
- Canonical URL.
- Publication date if relevant.
- Original duration.
- Local filename.
- Used time ranges.
- Transcript/caption source.
- Rights or permission note.
- Verification note.

Do not write “cleared” unless permission was actually verified.

## Rights, attribution, and privacy

- Separate technical access from usage rights.
- Prefer user-owned, licensed, public-domain, Creative Commons, or clearly authorized media for public deliverables.
- For analysis or a private draft using public material, preserve attribution and explain that publication rights still require review.
- Do not remove watermarks to disguise provenance.
- Do not imply endorsement by a speaker or brand.
- Use only the amount of third-party material needed for the requested editorial purpose.
- Treat private screens, personal information, faces, payment data, and credentials as sensitive. Exclude or obscure them before delivery.

## Verification wording

State what was actually verified:

- “The words, set, duration, and chapter order match the official full video.”
- “The social post is a 1:45 excerpt from the official 40:08 program.”
- “No authoritative full version was found; this edit uses the provided clip only.”

Avoid unsupported certainty such as “this is definitely the first ever interview” when only a repost caption says so.
