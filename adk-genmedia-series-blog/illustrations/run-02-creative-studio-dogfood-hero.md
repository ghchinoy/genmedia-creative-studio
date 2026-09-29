# Art-direction — Creative Studio (dogfood) hero (run tier / dogfood, post 6)

- **Post:** `run-02-creative-studio-dogfood.md`
- **Placement:** top hero, full-width. This is the **Creative Studio dogfood post** — the "studio that
  documents itself." It should feel like the same studio as the capstone, but now producing a **tidy,
  labelled, machine-readable package** rather than a single hero video.
- **Aspect ratio:** 16:9 · **image_size:** 2K · **output_filename:** `run-02-creative-studio-dogfood-hero.png`
- **Anchor axis colour:** **indigo/purple** structure (same engine, a profile switch) with a strong
  new **green** accent for the *deterministic verify + manifest* (the machine-readable contract — the
  post's one new idea). **Teal** appears once (the reused photoshoot still). Amber (Gemini) is a
  small spark. Green should read as "checked / verified / contract," distinct from a decorative tick.
- **Status:** render pending — queued to the EM credentialed render channel (no stub committed).

## Prompt (paste into Photoshoot / `nanobanana_image_generation`)

> Flat editorial vector illustration, warm and tactile, light paper-grain texture, soft long shadows,
> on a warm off-white background. Left-to-right, the idea is **a creative studio producing a neat,
> machine-readable package about itself**. On the left, a single **subject-brief card** with a small
> **amber** idea-spark slides along a **purple** ribbon/track (the plan) into a compact studio bench;
> the bench shows, briefly and cleanly, **three small numbered still panels** in a row (a storyboard —
> one flat **teal**-tinted camera/lens glyph beside them as the reused image tool) plus a small
> **waveform + microphone** (narration + music) and a tiny **film-strip/animatic** thumbnail. From the
> bench, an arrow leads to the **centre-right hero of the image**: a crisp, **green**-accented
> **manifest document/card** — a clean structured index (rows of faint list-ruling with small
> **green check marks** down the side, evoking a verified table of contents), sitting on top of a
> neatly wrapped/boxed **package** (a tidy labelled folder or parcel). The whole thing reads as
> "everything inside is accounted for and verified." On the far right, a small **downstream hand or
> gear/pipeline glyph** reaches for *only* the manifest card (a machine reading the contract). A
> subtle overall **indigo/purple spine** ties the plan → studio → package → manifest together. The
> mood is calm, precise, and trustworthy — a well-organised handoff, not a busy factory. Modern
> developer-blog aesthetic, generous negative space, upper-left third clear for a title overlay. No
> text beyond faint indistinct list-ruling, panel frames, and waveform marks (no legible words), no
> logos, not photoreal, no UI screenshots.

## Theme-compliance checklist (`graphic-theme.md`)
- [ ] **Indigo/purple spine** ties plan → studio → package → manifest (same engine, a profile switch)
- [ ] **Purple** plan ribbon carries the brief in (the `output_schema` `StoryboardPlan` — the
      walk/run session-state signature)
- [ ] **Green is the hero accent** on the **manifest card + verified check marks** (the new idea:
      deterministic verify-by-existence + a machine-readable contract) — distinct from a mere tick
- [ ] A **neatly boxed/labelled package** under the manifest (the point: a package a machine reads)
- [ ] **Three numbered still panels** (storyboard, stills-only; matches `MAX_SHOTS=3` / no Veo) +
      **one teal** camera glyph (photoshoot reused) + **waveform/mic** (narration+music) + tiny
      **animatic** thumbnail
- [ ] **Amber** spark (Gemini planning the beats) — kept small
- [ ] A **downstream consumer** glyph (hand/gear/pipeline) reaching for the **manifest only** (dogfood:
      the archivist reads the contract, never the internals)
- [ ] Flat editorial vector + paper grain; warm off-white ground; calm/precise mood
- [ ] Upper-left third clear; no legible baked text/logos/UI; not photoreal; 16:9

## Placement note
The teaching image here is the **manifest + verified package** — that is the post's one new idea and
must be the visual hero (centre-right, green-accented). The studio bench on the left is deliberately
compact (we've shown the full studio in post 5; here it's context, not the star). Keep the still
panels at **three** to match the storyboard profile's `MAX_SHOTS=3` / stills-only run and the real
`packages/lighthouse/` package (three verified panels). The downstream glyph reaching for *only* the
manifest is the dogfood point: a machine consuming a stable contract.

## Persona-continuity note
Reuse the established flat-vector studio look so this reads as the *same* studio from the capstone, now
in "documentation mode." No new human personas are required (this is a headless tool) — if a figure
is shown, keep it a small editor/operator consistent with the cast. The red-umbrella motif may appear
faintly inside one still panel as a series callback, but the subject is generic; the star is the
green manifest/package, not a character.
