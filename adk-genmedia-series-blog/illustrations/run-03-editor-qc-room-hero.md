# Art-direction — Editor's QC Room hero (run tier, post 7 / the series' last ADK construct)

- **Post:** `run-03-editor-qc-room.md`
- **Placement:** top hero, full-width. This is the **series' final teaching post** — the optional
  self-critique **LoopAgent**. It should feel like the same studio as the capstone, now with one more
  role at work: an **editor who checks the cut, catches one flaw, sends it back for a single fix, and
  stamps it approved**. The emotional beat is *trustworthy self-correction on a leash* — calm and
  precise, not anxious.
- **Aspect ratio:** 16:9 · **image_size:** 2K · **output_filename:** `run-03-editor-qc-room-hero.png`
- **Anchor axis colour:** **indigo** structure (the LoopAgent) with a strong **green** accent for the
  *measure / verify / approved* beat (the critic measures, and the corrected cut is stamped). A single
  **orange** touch marks the one caught flaw (the music running long). **Purple** appears once as the
  verdict slip (the structured `QCVerdict` in state). Amber (Gemini) is a small spark at the critic's
  judgement. Green should read as "measured / checked / approved," distinct from a decorative tick.
- **Status:** render pending — queued to the EM credentialed render channel (no stub committed).

## Prompt (paste into Photoshoot / `nanobanana_image_generation`)

> Flat editorial vector illustration, warm and tactile, light paper-grain texture, soft long shadows,
> on a warm off-white background. The scene is **an editor's quality-check room**: an editor figure at
> a review bench holds up a **finished film cut** (a small framed clip / filmstrip card) toward the
> light and measures it against a tall **checklist card** with a few faint list-rulings and small
> **green check marks** down the side. The composition reads as a gentle **loop**: a soft **indigo**
> circular arrow runs from the cut, to the editor's measuring glass, to a small **purple** verdict slip
> that reads as a stamped form, and — for **one** item — a thin **orange** arrow curves *back* to the
> bench (the single "fix and try again" pass), while a **green** arrow leads *forward* to a final
> **approved** cut with a clean **green** check stamp. Near the editor's measuring glass, show the one
> caught flaw simply and wordlessly: a **waveform/soundtrack bar that visibly extends past the end of
> the filmstrip** (the music running longer than the picture), with a small **orange** marker at the
> overrun. A tiny **amber** spark sits at the editor's eye/measuring glass (the judgement). Somewhere
> small, a **two-notch dial or a "2" gauge / a short chain-link leash motif** suggests the loop is
> bounded to a couple of passes — a safety limit, calm not alarming. The overall mood is **precise,
> trustworthy, unhurried** — a good editor doing a final check, not a frantic factory. Modern
> developer-blog aesthetic, generous negative space, upper-left third clear for a title overlay. No
> text beyond faint indistinct list-ruling, filmstrip frames, waveform marks, and dial notches (no
> legible words), no logos, not photoreal, no UI screenshots.

## Theme-compliance checklist (`graphic-theme.md`)
- [ ] **Indigo loop** structure (the `LoopAgent` — the round-trip from cut → measure → verdict → back)
- [ ] **Green is the verify/approve accent**: green check marks on the checklist AND the final
      **approved** stamp on the corrected cut (measure-then-approve — distinct from a mere tick)
- [ ] **One orange** element only — the single caught flaw (the overrunning soundtrack) + the *one*
      "send it back" pass; not a field of orange
- [ ] **Purple** verdict slip appears once (the structured `QCVerdict` in session state)
- [ ] **Amber** spark at the editor's eye/glass (Gemini judging from the measurement) — kept small
- [ ] The **flaw is shown by measurement**, wordlessly: a waveform/audio bar visibly longer than the
      filmstrip (music overruns the picture) — the concrete defect the critic catches
- [ ] A small **bounded-loop / leash** motif (a "2"-notch dial, two-step gauge, or short chain link) —
      the `max_iterations=2` safety cap, calm not alarming
- [ ] Flat editorial vector + paper grain; warm off-white ground; precise/unhurried mood
- [ ] Upper-left third clear; no legible baked text/logos/UI; not photoreal; 16:9

## Placement note
The teaching image here is **measure → catch one flaw → fix once → approve**, drawn as a bounded loop.
The green *approved* stamp on the corrected cut is the payoff and should be the clearest single beat;
the overrunning-waveform flaw is the second-clearest (it's the concrete thing the critic measures).
Keep the "send it back" pass to a **single** orange return arrow so the leash/bounded feel is obvious —
this is self-correction that is *safe because it ends*, not an anxious infinite spin.

## Persona-continuity note
Reuse the established flat-vector studio look so this reads as the *same* studio from the capstone, now
in "final-check mode." The editor may be the same editor figure who assembled the cut in the run-01
hero. The red-umbrella motif may appear faintly inside the filmstrip being reviewed as a series
callback, but the subject is generic; the star is the **green approved stamp + the measured loop**, not
a character. Avoid any legible words on the stamp or checklist (EM enforced wordless cards on the prior
hero — hold that line here).
