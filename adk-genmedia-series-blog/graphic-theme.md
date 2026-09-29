# Graphic theme — ADK Genmedia Series

**Owner:** `vaics-adk-series-archivist` (standing docs archivist)
**Status:** v1 (2026-09-07) — governs all illustrations + diagrams for the series blog.
**Scope:** the devrel *blog* series on the scratchpad (`blog/`). It is deliberately consistent
with, but not a replacement for, the in-repo per-agent READMEs (those follow the fixed 8-section
template in `photoshoot/README.md`).

This file is the single source of truth for how the series *looks*. Every diagram in
`blog/diagrams/` and every illustration art-direction in `blog/illustrations/` must comply with
it. If a post needs a visual the theme doesn't cover, extend this file first, then the asset.

---

## 1. The core idea the visuals must carry

The series has **one big idea** that the design doc calls the *three-fold balance* (§4.3): every
example serves three showcases at once, and none is "just glue."

| Axis | What it is | Signature colour | Diagram shape | Illustration motif |
|------|-----------|------------------|---------------|--------------------|
| **ADK** | The agent framework & its constructs — `LlmAgent`, `MCPToolset`, `SequentialAgent`, `ParallelAgent`, `AgentTool`, `output_key`/state | **Indigo** `#5B4FE9` | rounded rectangle | scaffolding / blueprint lines, connective structure |
| **genmedia MCP** | The media tools & servers — nanobanana, veo, lyria, chirp3, gemini-tts, avtool | **Teal** `#00A39C` | 3-D box (`box3d`) / cylinder | the physical craft tools of each persona (camera, clapperboard, mixing desk) |
| **Gemini** | The model's own reasoning, planning, multimodality | **Amber** `#F9A825` | ellipse | a warm "spark"/glow — the idea being art-directed |

**Rule of thumb for every visual:** if you can see indigo *structure*, teal *tools*, and an amber
*spark* in the frame, the three-fold balance is legible. A post whose diagram is all teal (pure
tool wiring) is a red flag that the post is reading as glue — fix the post, not just the picture.

---

## 2. Palette

### Brand / axis colours
| Token | Hex | Use |
|-------|-----|-----|
| `adk-indigo` | `#5B4FE9` | ADK constructs; primary structural lines |
| `adk-indigo-tint` | `#E8E6FD` | ADK node fills (light background) |
| `mcp-teal` | `#00A39C` | genmedia MCP servers/tools |
| `mcp-teal-tint` | `#DBF3F1` | MCP node fills |
| `gemini-amber` | `#F9A825` | Gemini reasoning; the "spark" |
| `gemini-amber-tint` | `#FDF0CE` | Gemini node fills |

### Semantic colours
| Token | Hex | Use |
|-------|-----|-----|
| `gotcha` | `#E8590C` | footguns, "the trap", model-gating errors — the thing the post exists to teach |
| `verified` | `#1E8E3E` | verify-by-existence / verify-by-listing success paths |
| `state` | `#8E24AA` | session state / `output_key` handoffs (walk & run tiers) |

### Neutrals
| Token | Hex | Use |
|-------|-----|-----|
| `ink` | `#1F2933` | body text, primary strokes |
| `slate` | `#52606D` | secondary text, edge labels |
| `mist` | `#9AA5B1` | muted borders, grid |
| `paper` | `#FBFBF8` | canvas / page background (warm off-white, not pure #FFF) |
| `cloud` | `#F1F3F4` | subtle panel fills |

Accessibility: keep body text at `ink` on `paper` (contrast > 12:1). Never put small text in
`gemini-amber` on white — amber is a fill/accent, not a text colour. Colour is never the *only*
signal: pair every axis colour with its shape (above) and, in diagrams, a text label, so the
series stays legible in greyscale and to colour-blind readers.

---

## 3. Type feel

The series voice is a *human learner's tutorial voice* (design §8): second person, encouraging,
minimal ceremony. The type should feel modern, friendly, and technical-but-not-cold.

| Role | Family (with fallbacks) | Notes |
|------|-------------------------|-------|
| Display / headings | **Space Grotesk**, then `Google Sans`, then system geometric sans | slightly quirky geometric — approachable, not corporate |
| Body | **Inter**, then system UI sans | high legibility at long reading lengths |
| Code / mono | **JetBrains Mono**, then `Roboto Mono`, `ui-monospace` | code excerpts, tool/param names, `gs://` URIs |

Conventions:
- Tool names, params, and model ids are **always** in `mono` (`nanobanana_image_generation`,
  `veo-3.1-fast-generate-001`, `output_key`).
- The "one new ADK concept" per post is bolded on first mention.
- Callout labels (used in prose and diagrams): **What you'll build**, **What you'll learn**,
  **The gotcha this teaches**, **Three-fold balance**, **See also**, **Next**.

---

## 4. Illustration style guide (Nano Banana)

Real renders are produced through the credentialed genmedia stack (see §6 and each art-direction
file). Whether generated now or later, every series illustration obeys **one** look so covers and
in-post art read as a set.

- **Medium/style:** flat editorial vector with a light paper-grain texture; soft long shadows;
  gentle depth. *Not* photoreal, *not* 3-D render, *not* clip-art. Think "modern developer-blog
  hero, warm and tactile."
- **Palette:** the §2 palette. Each persona illustration is anchored by **one** axis colour that
  matches what the post foregrounds, with the other two present as accents:
  - Photoshoot → amber-forward (Gemini's prompt craft is the star), teal camera, indigo frame.
  - Director → teal-forward (video/Veo craft) with a prominent `gotcha`-orange warning motif
    (the model-gating footgun), amber spark, indigo clapper structure.
  - Overview → balanced tri-colour (the whole arc).
- **Composition:** a single clear persona or object as focal point; generous negative space on
  `paper`; keep the top-left third clear if the image may carry a title overlay. Default hero
  aspect ratio **16:9**; in-post spot illustrations **1:1**.
- **The persona cast (consistent across the series):**
  - *Photographer / art director* (Photoshoot) — camera, a single art-directed subject (e.g. a
    red umbrella).
  - *Film director* (Director/Videographer) — clapperboard, viewfinder, a strip that hints at
    motion.
  - *Music producer* (Music Producer, later) — mixing desk, waveform, mic.
  - *Scriptwriter/storyboarder*, *creative director* (walk/run, later).
- **Recurring motifs:** the **amber spark** = a terse idea becoming rich; a **green check /
  listed-file glyph** = verified artifact; an **orange warning triangle** = the footgun.
- **Type in image:** avoid baked-in body text (localisation + accuracy). Short single-word labels
  only if essential; prefer captions in the post.
- **Do NOT:** invent product UI, show fake screenshots, depict logos of real products, or imply a
  capability the code doesn't ship. No stock-photo realism.

Every illustration ships with an **art-direction record** in `blog/illustrations/` containing: the
exact generation prompt, intended placement, aspect ratio, anchor axis colour, and a theme-
compliance checklist. Renders are existence-verified real bytes — **never** stub/placeholder files
committed as if they were illustrations (the Simulation Trap).

---

## 5. Diagram conventions (Graphviz)

All diagrams are authored as Graphviz `.dot` in `blog/diagrams/` and rendered to **both** `.svg`
(web) and `.png` (fallback). No credentials required. Render with:

```bash
dot -Tsvg blog/diagrams/<name>.dot -o blog/diagrams/<name>.svg
dot -Tpng -Gdpi=144 blog/diagrams/<name>.dot -o blog/diagrams/<name>.png
```

**Node vocabulary** (this is the load-bearing part — keep it identical across every diagram so a
reader learns the visual language once):

| Concept | `shape` | `style` / `fill` | `color` (border/text) |
|---------|---------|------------------|-----------------------|
| ADK construct (`LlmAgent`, `SequentialAgent`, `ParallelAgent`, `MCPToolset`, `AgentTool`) | `box`, `style="rounded,filled"` | `adk-indigo-tint` `#E8E6FD` | `adk-indigo` `#5B4FE9` |
| genmedia MCP server / tool | `box3d`, `style="filled"` | `mcp-teal-tint` `#DBF3F1` | `mcp-teal` `#00A39C` |
| Gemini reasoning step | `ellipse`, `style="filled"` | `gemini-amber-tint` `#FDF0CE` | `gemini-amber` `#F9A825` (border), `ink` text |
| Session state / `output_key` | `note`, `style="filled"` | white | `state` `#8E24AA` (dashed border) |
| User / external artifact (image, mp4, gs:// URI) | `folder` (artifact) / `oval` (user) | `cloud` `#F1F3F4` | `slate` `#52606D` |
| Gotcha / footgun annotation | `box`, `style="rounded,filled,dashed"` | white | `gotcha` `#E8590C` |
| Verify step | `box`, `style="rounded,filled"` | white | `verified` `#1E8E3E` |

**Edge vocabulary:**
- Solid `ink` arrow = control/data flow (call → return).
- Dashed `state`-purple arrow labelled with the key name = state handoff via `output_key`.
- Dashed `gotcha`-orange arrow = the failure path a footgun causes (used to *contrast* the correct
  path).
- Edge labels in `slate`, `mono` where they name a param/tool.

**Global graph attributes** (paste into every `.dot` header for consistency):

```dot
graph [fontname="Inter", bgcolor="#FBFBF8", rankdir=TB, splines=true, nodesep=0.35, ranksep=0.55];
node  [fontname="Inter", fontsize=11, penwidth=1.6];
edge  [fontname="JetBrains Mono", fontsize=9, color="#1F2933", penwidth=1.3];
```

**Legend:** every standalone diagram includes a small legend subgraph mapping the three axis
colours/shapes, so a diagram is self-explaining out of context.

**Diagram inventory (maintained):**
- `series-arc` — the crawl→walk→run arc: which ADK construct each tier adds, monotonic ADK weight.
  Covers all eight arc steps end to end (Tier-0 → crawl ×3 → walk → run ×3).
- `tier0-doorway` — the Tier-0 doorway post (#1811): one `LlmAgent` (`genmedia_agent`,
  `gemini-3.8-flash`, global region) → four stdio `MCPToolset`s (nanobanana with `tool_filter`, chirp3,
  veo, avtool) → the four `mcp-*-go` servers (teal `box3d`, avtool noting `ffmpeg`+`ffprobe`) → the green
  verify-by-existence step. The plain "model + tools" shape every later post specializes; standard legend.
- `photoshoot` — `LlmAgent` → `MCPToolset(nanobanana)` → image artifact, with Gemini prompt-craft
  and the verify-by-existence step.
- `director` — `LlmAgent` → `MCPToolset(veo)` → GCS mp4, foregrounding the model-gating footgun
  (contrast path) and verify-by-listing.
- `music-producer` — one `LlmAgent` → three `MCPToolset`s (`tool_name_prefix` music/tts/av) →
  lyria bed + gemini-TTS VO → avtool mix, with the crosswalk and lyria-dropped-params gotcha.
- `scriptwriter-storyboarder` — `SequentialAgent`(scriptwriter → storyboarder); the walk-tier
  signature: the **purple session-state handoff** (`output_key="shot_list"` → `{shot_list}`) with the
  same-key contract gotcha and per-shot verify + 1:1 shot→image map.
- `ad-creative-director` — the run-tier capstone: `SequentialAgent[planner → ParallelAgent(shots) →
  audio → assembler]`. Run-tier signature — an indigo spine that **contains a `ParallelAgent`
  fan-out** (three static shot slots), the crawl personas **reused as teal `AgentTool` boxes**
  (photoshoot/director/music-producer in a dashed reuse cluster), the planner's **purple
  `output_schema` plan** (`AdPlan` → `{ad_plan}`), and two orange gotchas (static fan-out cap
  `MAX_SHOTS=3`; the Lyria-bed-vs-avtool trim seam). Ends on verify-by-existence of one `final_ad.mp4`.
- `creative-studio-dogfood` — the dogfood post (#1823): the SAME engine run through a **second
  `storyboard` profile** (an indigo `Profile` note flips the switches: stills-only, no Veo,
  `stills_animatic`, `emit_package=True`) via a headless CLI. New visual element — the **green
  deterministic, non-LLM packager** (`build_manifest`, verify-by-existence) emitting a **green
  `manifest.json` contract** read by a downstream consumer (the archivist); purple `StoryboardPlan`
  session-state; orange **fail-closed** gotcha (exit code IS the contract; no stubs; empty plan never
  verifies). Introduces green as *deterministic verify / manifest* alongside the standard verify green.
- `editor-qc-room` — the QC post (#1824), the series' **last ADK construct**: the optional self-critique
  **`LoopAgent`** wrapping stage four of the same engine. Signature — an indigo `LoopAgent` cluster
  (`assembler` first, `critic` second), the critic's **green `probe_media_durations` measurement**
  (verify-by-existence + the 1.0s sync tolerance), a **purple `QCVerdict` session-state note**
  (`acceptable` required → fails loud), an amber Gemini spark (judging from the numbers), and **two
  green stop-guarantees** (escalate via `exit_loop` / the `max_iterations=2` hard cap). One orange
  gotcha — the *taught* defect: the `enable_qc`-gated first-pass skipped trim that makes the ~30s Lyria
  bed overrun, so the critic has a real measured flaw to catch. Green here also reads as *measure /
  verify / stop-guarantee*; the single orange arrow is the one bounded re-assemble pass
  (`correction_notes` via `{qc_verdict?}`).

---

## 6. Where the assets come from (provenance & anti-fake rule)

- **Diagrams:** authored + rendered here with `dot` (graphviz 2.43.0 confirmed installed). Fully
  reproducible, no creds.
- **Illustrations:** the *art-direction* (prompt + placement + theme check) is authored here now.
  **Real renders require the credentialed genmedia stack** (Vertex ADC + genmedia suite ≥ v3.18.1
  + `GENMEDIA_BUCKET`) — the same stack the series' own Photoshoot/Director agents use. Until that
  path is routed to the archivist (or the dogfooding "storyboard-package" tool lands), illustration
  files hold art-direction only. **No placeholder image is ever committed as though it were a
  finished illustration.**

---

## 7. Changelog
- **v1 (2026-09-07):** initial theme — palette, type, illustration style, Graphviz vocabulary.
  Established from the merged crawl tier (PR-0/1/2) and design §4.3/§8.
