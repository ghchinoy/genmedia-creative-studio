# Art-direction — Ad creative-director's assistant hero (run tier / capstone)

- **Post:** `run-01-ad-creative-director.md`
- **Placement:** top hero, full-width. This is the **run-tier capstone** hero — it should read as the
  whole studio finally working together, the visual payoff of crawl → walk → run.
- **Aspect ratio:** 16:9 · **image_size:** 2K · **output_filename:** `run-01-ad-creative-director-hero.png`
- **Anchor axis colour:** balanced but **indigo-led** structure (ADK's `SequentialAgent ⊃
  ParallelAgent` is the new concept — an ordered pipeline that fans out), with a distinct **purple**
  accent for the shared plan (the walk/run session-state signature), **teal** for the reused
  genmedia specialists, and an **amber** creative spark at the director. All three axes are High
  here, so the frame should feel like the fullest, most orchestrated composition in the series.
- **Status:** render pending — queued to the EM credentialed render channel (no stub committed).

## Prompt (paste into Photoshoot / `nanobanana_image_generation`)

> Flat editorial vector illustration, warm and tactile, light paper-grain texture, soft long
> shadows, on a warm off-white background. A left-to-right **creative-studio production line** that
> reads as one orchestrated team. On the far left, a **creative director** persona at a desk hands
> off a single **brand-brief card** with a small **amber** idea-spark above their head (the brief
> becoming a plan); the card slides along a clearly drawn **purple hand-off ribbon/track** — a
> labelled shared channel — that threads through the whole scene as the spine. In the centre, the
> ribbon **fans out into three parallel lanes stacked vertically**, each lane a small **shot team**
> working at the same time: in every lane a **photographer** producing a framed still and, right
> beside them, a **videographer/camera** turning that still into a short film-strip clip (a visible
> still→clip pairing, three lanes running concurrently). Below or alongside, a **musician** persona
> lays down a waveform music bed and a small microphone for voiceover. On the far right, an
> **editor** at a timeline **assembles one finished video** — a single clean film frame / play-button
> card marked with a small **green check** (the verified final ad). The reused specialists (the
> three photographer+camera pairs and the musician) are tinted with a **teal** accent to read as the
> same trusted equipment from earlier chapters; the director, the lanes, and the editor's timeline
> carry the **indigo/purple** pipeline spine. The overall shape must read clearly as: one brief →
> three shots in parallel → scored → one assembled ad. Modern developer-blog aesthetic, generous
> negative space, upper-left third clear for a title overlay. No text beyond faint indistinct card
> ruling, film-strip frames, and waveform marks (no legible words), no logos, not photoreal, no UI
> screenshots.

## Theme-compliance checklist (`graphic-theme.md`)
- [ ] **Indigo/purple pipeline spine** prominent, and it visibly **fans out into three parallel
      lanes** then re-converges to one output (ADK `SequentialAgent ⊃ ParallelAgent`)
- [ ] **Purple** hand-off ribbon = the shared plan / session-state (`output_schema` → `{ad_plan}`);
      the walk/run signature carried forward from the Scriptwriter/Storyboarder hero
- [ ] **Three parallel shot teams**, each a **still → clip pairing** (Photoshoot + Director reused) —
      the "in parallel" and "reuse the specialists you built" ideas, both visible
- [ ] The reused specialists tinted **teal** (genmedia MCP axis, High here) and reading as the
      *same* cast from the crawl heroes (persona continuity)
- [ ] **Amber** spark at the director (Gemini writing the plan) — Gemini axis, High
- [ ] A **musician + microphone** element (music bed + voiceover) — the Music Producer reused
- [ ] An **editor at a timeline** assembling **one** finished ad, with a **green check** (verify by
      existence; a single final `.mp4`, not a folder of loose clips)
- [ ] Flat editorial vector + paper grain; warm off-white ground
- [ ] Upper-left third clear; no legible baked text/logos/UI; not photoreal; 16:9

## Placement note
This is the **fullest** hero in the series and the arc's payoff: it must say at a glance "one brief
in, one finished ad out, built by the whole crew working together — with three shots happening at
once." The three parallel lanes are doing the teaching (that's the `ParallelAgent` fan-out); the
purple ribbon threading through is the shared plan; the single checked film frame on the right is the
one assembled, verified ad. Keep the shot lanes at **three** so the picture matches the agent's fixed
three-slot shot stage (`MAX_SHOTS = 3`).

## Persona-continuity note
Reuse the established flat-vector cast so the photographer, videographer, and musician read as the
*same* specialists from the Photoshoot, Director, and Music Producer heroes — the whole point of the
capstone is that these are the collaborators you already built, now conducted by the new creative
director persona. The red-umbrella motif may appear faintly as the "hero product" inside one shot
lane's still/clip as a friendly series callback, but it is optional and must not dominate; the brand
subject is generic (a can/product) rather than any real logo.
