> ⚠️ **STAGING / REVIEW ONLY. This branch is NEVER merged to `main`.** It exists so the ADK
> Genmedia blog series can be read with rendered images (hero illustrations + Graphviz diagrams)
> for the coordinator and owner's **cycle-7 completeness review**. It is NOT a publication: the real
> venue is **Medium + the Google Developers forum**, and the durable source of truth is the team
> scratchpad, not this repo. Diagram embeds on this branch point at PNG copies so GitHub renders
> them reliably; the canonical posts use SVG. The new Tier-0 post's hero illustration is a known,
> declared gap (no placeholder, stub, or borrowed image is committed). Start with
> [`00-overview.md`](00-overview.md), then the Tier-0 doorway, and read the nine posts below in order.

# ADK Genmedia Series — blog (index)

The devrel **blog series** that runs alongside the ADK genmedia example code, maintained **in
parallel with each tier milestone as it merges**. This directory is the durable home of the posts,
their diagrams, illustration art-direction, and the shared visual identity.

- **Owner:** `vaics-adk-series-archivist` (standing docs archivist; long-lived).
- **Audience & register:** written for **creative builders** — marketers, brand/content teams,
  creative technologists accelerating brand-aligned creative assets — in a *Think With Google*
  register: lead with the creative outcome, keep code light and reassuring, never lose a verified
  fact. (Not "developers-as-coders.")
- **Publication venue:** **Medium** + the **Google Developers forum**
  (https://discuss.google.dev/c/google-cloud/14). This scratchpad `blog/` is the durable **source of
  truth**; the Medium/forum versions are rendered from it. Written toward Medium article format
  (strong hero image, outcome-selling headline, scannable sections).
- **Source of truth:** `GoogleCloudPlatform/genmedia-creative-studio` @ `main`. Every post
  describes code that is **merged**, and every capability/setting/behavior is verified against the
  shipped agent and a real credentialed run — never a design doc or PR description.
- **Cadence:** a post goes live only after its agent is merged *and* passes a real credentialed run.
  Between milestones the archivist is blocked, awaiting the coordinator's next signal.

## Files
- [`graphic-theme.md`](graphic-theme.md) — the series visual identity (palette, type, illustration
  style, Graphviz diagram vocabulary). Governs every asset here.
- [`00-overview.md`](00-overview.md) — the series entry point / crawl→walk→run promise.
- `crawl-01-photoshoot.md`, `crawl-02-director.md`, … — one post per milestone.
- [`diagrams/`](diagrams/) — Graphviz `.dot` sources + rendered `.svg`/`.png`.
- [`illustrations/`](illustrations/) — Nano Banana art-direction (+ real renders once a credentialed
  path is routed to the archivist; no fakes meanwhile).

## Post status

| # | Tier | Post | Agent (merged) | Diagram | Illustration | Post status |
|---|------|------|----------------|---------|--------------|-------------|
| — | — | [00-overview](00-overview.md) | — | `series-arc` ✅ | art-direction ✅ / render ✅ | **draft** |
| 0 | tier0 | [tier0-01-meet-your-studio](tier0-01-meet-your-studio.md) | PR #1811 ✅ | `tier0-doorway` ✅ | — (hero: known gap, deferred) | **draft (new, cycle 7)** |
| 1 | crawl | [crawl-01-photoshoot](crawl-01-photoshoot.md) | PR #1812 ✅ | `photoshoot` ✅ | art-direction ✅ / render ✅ | **draft (this cycle)** |
| 2 | crawl | [crawl-02-director](crawl-02-director.md) | PR #1814 ✅ | `director` ✅ | art-direction ✅ / render ✅ | **draft (this cycle)** |
| 3 | crawl | [crawl-03-music-producer](crawl-03-music-producer.md) | PR #1815 ✅ | `music-producer` ✅ | art-direction ✅ / render ✅ | **draft** |
| 4 | walk | [walk-01-scriptwriter-storyboarder](walk-01-scriptwriter-storyboarder.md) | PR #1816 ✅ | `scriptwriter-storyboarder` ✅ | art-direction ✅ / render ✅ | **draft** |
| 5 | run | [run-01-ad-creative-director](run-01-ad-creative-director.md) | PR #1821 ✅ | `ad-creative-director` ✅ | art-direction ✅ / render ✅ | **draft** |
| 6 | run (dogfood) | [run-02-creative-studio-dogfood](run-02-creative-studio-dogfood.md) | PR #1823 ✅ | `creative-studio-dogfood` ✅ | art-direction ✅ / render ✅ | **draft** |
| 7 | run | [run-03-editor-qc-room](run-03-editor-qc-room.md) | PR #1824 ✅ | `editor-qc-room` ✅ | art-direction ✅ / render ✅ | **draft (this cycle)** |

Legend: ✅ done · ⏳ pending/merging. **All eight series hero illustrations** (overview ×1, crawl ×3, walk ×1, run
×3) are now **real existence-verified renders** (2752×1536 PNG, produced on the credentialed genmedia
stack via the EM render channel and theme-compliance-reviewed by the archivist) dropped beside their
art-direction in [`illustrations/`](illustrations/). No placeholder was ever committed. The new Tier-0
post (cycle 7) ships text + a Graphviz diagram only; its hero illustration is a **known gap**, deferred
to the credentialed render channel (no placeholder committed).

## The through-line (map)

The series is a single numbered path; each step adds **exactly one** ADK construct on top of the
last, while Gemini's reasoning stays front-and-centre from the very first agent. (Rendered:
[`diagrams/series-arc.png`](diagrams/series-arc.png).)

1. **Meet your studio** → [the refreshed Tier-0 `adk/` sample](tier0-01-meet-your-studio.md) — *an
   agent is an `LlmAgent` + `MCPToolset`s; the LLM drives across many tools.* (PR #1811)
2. **Your first genmedia agent** → **Photoshoot** — *one `LlmAgent` + one `MCPToolset`
   (`tool_filter`); output modes + verify-by-existence.* (PR #1812)
3. **Now with video** → **Director / Videographer** — *same shape, video; explicit Veo-3 model to
   clear the audio footgun; verify by listing.* (PR #1814)
4. **Three servers, one agent** → **Music Producer** — *multiple `MCPToolset`s, `tool_name_prefix`,
   the naming crosswalk.* (PR #1815 ✅ — **crawl tier complete**)
5. **Your first pipeline** → **Scriptwriter / Storyboarder** — *`SequentialAgent` + `output_key`
   state passing between agents.* (PR #1816 ✅ — **walk tier begins**)
6. **A real multi-agent app** → **Ad creative-director's assistant** — *`SequentialAgent` ⊃
   `ParallelAgent` + `AgentTool`, composing the persona agents; `output_schema` plan.* (PR #1821 ✅
   — **run tier begins: the arc's payoff**)
7. **The studio that documents itself** → **Creative Studio (dogfood)** — *a second `storyboard`
   profile on the same engine (the `build_root_agent(profile)` seam) + a headless, deterministic
   packager that emits a versioned `manifest.json` verified by existence.* (PR #1823 ✅ — **dogfood:
   the studio packages its own output for downstream tools**)
8. **The editor who checks the work** → **Editor's QC Room** — *an optional (shipped enabled in both
   profiles), bounded `LoopAgent` self-critique stage: the assembler builds, a critic MEASURES the cut (ffprobe) and either escalates
   to stop or sends correction notes for one more pass, hard-capped by `max_iterations`.* (PR #1824 ✅
   — **the series' last ADK construct: self-correction, guaranteed to end**)

Each step ends with "what you learned," a link to the next, and a **See also** cross-link to the
non-ADK skill/demo that does the same job on another surface — the series *complements* the skills,
it never forks them.

## The three-fold balance (why no post is "just glue")

Every post carries a **three-fold balance** callout — where its agent lands on (1) **ADK features**,
(2) **genmedia MCP breadth**, (3) **Gemini's own reasoning**. ADK weight rises monotonically across
the arc; MCP breadth peaks at Music Producer and the Run agent; Gemini stays **High at both ends**.

| Post | ADK | genmedia MCP | Gemini |
|------|-----|--------------|--------|
| 0 · Tier-0 sample | Med | High | Med |
| 1 · Photoshoot | Med | Low/Med | **High** |
| 2 · Director | Med | Med | **High** |
| 3 · Music Producer | **High** | **High** | Med |
| 4 · Scriptwriter/Storyboarder | **High** | Med | **High** |
| 5 · Ad creative-director | **High** | **High** | **High** |
| 6 · Creative Studio (dogfood) | **High** | Med | **High** |
| 7 · Editor's QC Room | **High** | Med | **High** |

## Maintenance protocol (for the standing archivist)

On each milestone message from `vaics-adk-series-coord`:
1. Read the newly merged source (`sample-agents/adk-genmedia-series/<agent>/`), verifying every
   command/flag/model-id/gotcha against the shipped code.
2. Draft/refresh the post + its Graphviz diagram + its illustration art-direction, all per
   `graphic-theme.md`.
3. Update the **Post status** table above.
4. Report to the coordinator (items of concern + any illustration-render need), then go blocked
   awaiting the next milestone.

## Items of concern (open)
See the cycle report to the coordinator. Current-cycle guesses (resolved as best-effort) are logged
there; the standing list lives in the archivist's state.
