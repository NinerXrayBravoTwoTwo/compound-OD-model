# Compounding Crisis Model - Internal Asset Notes

This file is retained for maintainers. **Users and distributors should read `README.md`** in this folder: it covers how to run the model on each OS, troubleshooting, the model assumptions, data source, license, and how to rebuild the distribution.

## Quick technical summary (for maintainers)

- Primary artifact: `washington_overdose_model.html` (page layout, inlined Tailwind v3 CSS, and the model logic in its main `<script>`). Renamed from `seattle_overdose_model.html` in October 2026 because the data are statewide; `seattle_overdose_model.html` is now a redirect stub (meta refresh + JS, keeps `?query`/`#hash`, visible link, `noindex`, canonical to the new name). Keep it so old links, bookmarks and the old download name keep working.
- Required runtime siblings (must stay next to the .html; the page shows a red "files could not be loaded" banner without them):
  - `chart.umd.min.js` (Chart.js 4.5.1, MIT): the chart. Without it the numbers and table still work.
  - `math-utils.js`: `MathUtils.Td` / `DblPredict` (doubling time / half-life), ported from the author's C# utilities.
  - `overdose-data.js`: observed 2018–2025 WA DOH data (2025 preliminary) plus helpers.
- Images and documents referenced by the page: `time2doubleequations-dark.gif`, `Washington_Overdose_death_2018-25.gif` (verification graphic: 2018–2024 DOH counts + 2025 compounding estimate, linear and ln charts). Also bundled, but not referenced by the page: `Washington_Overdose_death_2018-25.png` (higher-resolution PNG) and `Washington_Overdose_death_2018-25.pdf` (printable PDF). The old 2018-24 GIF/PDF (May 2025 preliminary table) were removed in October 2026.
- Also bundled: `LICENSE.txt`, `README.md`, this file, and the `seattle_overdose_model.html` redirect stub. That's **12 files** in the standalone bundle: **4 needed to run** (`.html` + 3 `.js`), 2 images shown in the page, 2 additional graphic formats (PNG and PDF) not needed to run, 3 docs/legal, and the redirect stub.
- All asset references in the HTML are bare relative file names (no leading `/`), so the bundle is portable when the files travel together.
- Model constants (lever shares 0.65 / 0.35, maximum shift 1.5, floor 0.5×/yr, stable threshold 12 years, default horizon 6 years; slider max 10 is in the `#year-slider` markup) are at the top of the main `<script>` and documented in `README.md` → "What the model does".

## Current location

The source of truth is this GitHub repository: <https://github.com/NinerXrayBravoTwoTwo/compound-OD-model>.

The download archives are built into `dist/` by `sbin/regen-dist.sh` / `sbin/regen-dist.ps1`. The scripts also copy the archives to the legacy names `dist/seattle-overdose-model-standalone.*` so old download links keep working. They are git-ignored, so publish the `dist/` archives wherever you host the download.

## Integration

You can embed the page in an iframe (see `README.md` → "Using it on your own website"). You can edit the .html file in isolation.

## License (summary for maintainers)

The model is **AGPL-3.0-or-later** (see `LICENSE.txt`). Chart.js and Tailwind CSS are MIT and keep their own notices. Network deployment of modified versions requires making the complete corresponding source available.

## Acknowledgments (brief)

- Math ported from the author's C# utilities (T_d / projection helpers).
- © 2026 Jillian England. Licensed under the GNU Affero General Public License v3.0 or later (AGPL-3.0-or-later); see the visible legal footer in the model and `LICENSE.txt`.
- The inlined Tailwind v3 + local Chart.js approach was chosen after CDN versions produced tracking blocks and graphics regressions for some visitors.
