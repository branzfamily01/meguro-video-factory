# Editorial Design

Use this file for recuts, digests, montages, translations, alternate-angle edits, and multi-source pieces.

Evidence anchors: the TED/ADHD and money series used exact three-minute
multi-section edits; `altman-bottleneck-5min` used hook-then-rewind;
`nishino-generation-digest` used a dual-source five-minute map; the four
`elon-forbes-*` projects reused one master through non-overlapping angles.

## Write the thesis first

Write one sentence that the finished video proves or explains. Every selected segment must serve that sentence.

Weak: “A summary of this interview.”  
Strong: “The bottleneck for scaling AI moves from semiconductors to electricity, and mission is what coordinates the supply chain.”

## Choose complete thought units

Select blocks that contain a usable setup, claim, support, and landing. Avoid cuts that:

- End in the middle of a clause.
- Remove a qualification that changes meaning.
- Join two answers into a claim the speaker did not make.
- Use reaction shots or silence to imply a false response.
- Repeat the same point only to fill time.

Inspect at least several seconds before and after each proposed boundary.

## Story shapes

Choose a shape that fits the source.

| Shape | Best for | Sequence |
| --- | --- | --- |
| Hook then rewind | Interviews with a striking late answer | strongest answer → context → return to answer → implication |
| Problem to mechanism | Research and educational talks | felt problem → mechanism → evidence → practical meaning |
| Steps | Tutorials and screen recordings | desired result → prerequisites → actions → check → outcome |
| Myth to correction | Claims and misinformation | familiar claim → why it appeals → evidence → corrected model |
| Before to after | Product/site/workflow demos | friction → intervention → visible change → proof |
| Escalation | Talks with accumulating stakes | small effect → system effect → consequence → decision |
| Chapter digest | Long seminars | 3–7 non-overlapping chapters with one clear purpose each |
| Alternate angle | Reusing a prior source | identify previous thesis and cuts → select unused evidence → state a distinct thesis |

## Duration guidance

Do not fill time merely because it is available.

- 15–30 seconds: one event or one claim.
- 45–90 seconds: hook, mechanism, payoff.
- 3 minutes: 4–6 meaningful beats.
- 5 minutes: one coherent argument with room for source context.
- Longer than 5 minutes: use explicit chapters and a stronger review plan.

For exact-duration work:

1. Sum source durations before authoring.
2. Reserve time for title/outro only when they add value.
3. Cut on words, breaths, or completed visual actions.
4. Prefer a few tenths of a second of natural room to clipped phonemes.
5. Validate against the target at frame precision.

## Cut-plan format

Copy `assets/templates/cut-plan.json`.

```json
{
  "targetDuration": 180,
  "fps": 30,
  "toleranceFrames": 1,
  "segments": [
    {
      "id": "hook",
      "source": "source/interview.mp4",
      "start": 2876.4,
      "end": 2888.67,
      "label": "The bottleneck answer",
      "allowOverlap": false
    }
  ]
}
```

The validator sums `(end - start) / speed` for every segment. Use `speed` only for intentional retiming; never speed up speech merely to hit a target unless the user approves.

## Transcript and translation

- Preserve names, numbers, technical terms, and uncertainty.
- Translate meaning, not English word order.
- Keep on-screen Japanese shorter than a full written translation.
- Split captions by spoken idea, not arbitrary character count.
- Correct only errors that affect the selected segments; do not polish an unused hour-long transcript without need.
- Keep a clean transcript separate from edited caption copy.

## Caption modes

| Mode | Use |
| --- | --- |
| Full captions | Accessibility, fast speech, noisy audio, foreign-language source |
| Edited translation | Foreign-language source where readability matters more than verbatim density |
| Selective key cards | Same-language interviews with existing subtitles or strong visual focus |
| No captions | Music-first or purely visual work where text would weaken the piece |

## Multi-source editing

Use multiple sources only when each has a documented job:

- Main source supplies the argument.
- Secondary source supplies a missing section, example, or visual proof.
- Generated B-roll supplies atmosphere or illustration without pretending to be documentary evidence.

Label source changes when viewers could otherwise misunderstand them.

## Screen tutorials

- Remove dead waits, accidental navigation, and private UI.
- Preserve enough cursor/context movement for the action to be reproducible.
- Use step labels and focus moves outside important UI.
- Zoom only when it improves legibility.
- Confirm that the demonstrated result appears on screen.

## Revision behavior

When feedback says “抽象的”, “もっと具体的”, or “別の重要ポイント”:

1. Re-open the transcript and prior cut plan.
2. State what made the prior thesis abstract or repetitive.
3. Choose a new thesis backed by demonstrable actions or unused evidence.
4. Replace the story structure, not just the title cards.
5. Re-run duration and boundary checks.
