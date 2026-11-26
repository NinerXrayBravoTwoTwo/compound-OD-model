# Washington State Overdose Deaths • Interactive Policy Model

A standalone, interactive web page that projects Washington State overdose deaths forward using the observed compounding (exponential) growth rate, with two policy sliders — *discourage addict migration / inflow* and *criminalize use & distribution* — that bend the curve.

The data are statewide (Washington State residents), not Seattle-only, so the page is named `washington_overdose_model.html`. It was previously `seattle_overdose_model.html`; that name is now a small redirect page in the download, so old links and bookmarks keep working.

- **Source and downloads:** <https://github.com/NinerXrayBravoTwoTwo/compound-OD-model>

---

## How to run it (no install, no internet, no extensions)

You only need a web browser with JavaScript turned on (it is on by default). **No plugins, extensions, add-ons, servers or internet connection are needed** — everything is in the downloaded folder.

**Browsers:** current Chrome, Microsoft Edge, Firefox, Safari, or ChromeOS Chrome. Tested with Chrome 154, Firefox 155 and WebKit 26.6 (Safari's engine) in October 2026. Versions from roughly 2022 or newer should work; older versions have not been tested.

### The one rule: extract first, keep the files together

The page needs the other files next to it (`chart.umd.min.js`, `math-utils.js`, `overdose-data.js` and the images). If you open the page **from inside the zip** without extracting it, or copy only the `.html` file somewhere else, the page shows a red **"Some model files could not be loaded"** banner instead of numbers.

### Windows 10 / 11

1. Download `washington-overdose-model-standalone.zip`.
2. Open your **Downloads** folder, right-click the zip → **Extract All…** → **Extract**. A new folder opens.
3. Double-click **`washington_overdose_model.html`** (it may show as `washington_overdose_model` with a browser icon). It opens in your default browser.
   - If it opens in some other program, right-click it → **Open with** → choose Edge, Chrome or Firefox.
   - Got the `.tar.gz` instead? Open **Command Prompt** in the Downloads folder and run `tar -xf washington-overdose-model-standalone.tar.gz`, or use 7-Zip.

### macOS

1. Download the `.zip` (or `.tar.gz`). Safari usually unzips it automatically into a folder in **Downloads**; otherwise double-click the archive.
2. Double-click **`washington_overdose_model.html`**. To pick a browser: right-click (Control-click) → **Open With** → Safari, Chrome or Firefox.
   - No Safari settings need to be changed; the page doesn't load anything from the internet.

### Linux

1. Extract: `unzip washington-overdose-model-standalone.zip -d overdose-model` (or `mkdir overdose-model && tar -xzf washington-overdose-model-standalone.tar.gz -C overdose-model`), or double-click the archive in your file manager and extract it.
2. Open: double-click `washington_overdose_model.html` in the file manager, or run `xdg-open overdose-model/washington_overdose_model.html`.
   - If your browser is a Snap package (for example, the default Firefox on Ubuntu), keep the folder inside your home folder; Snap browsers can't open files in some other locations, such as `/tmp`.

### ChromeOS (Chromebook)

1. Download the zip, open the **Files** app → **Downloads**, and click the zip. ChromeOS opens it like a drive.
2. Select all the files inside, **copy** them (Ctrl+C), go to **My files**, make a new folder, and **paste** (Ctrl+V).
3. Double-click **`washington_overdose_model.html`** in that folder. It opens in Chrome.

### Phones and tablets (iPhone, iPad, Android)

Phones and tablets don't reliably let a downloaded web page load the other files in its folder, so the downloaded bundle is meant for computers. To use the model on a phone or tablet, you need a hosted copy (see the repository link at the top).

### Using the model

- **Growth rate period:** 2019–2023 (the high-growth years) or 2018–2025 (all data years, the default; 2025 is preliminary). Sets the natural, no-policy growth rate.
- **OD cause:** total, fentanyl, opiates, stimulants (DOH psychostimulants category, mostly methamphetamine; excludes cocaine), oxy (prescription opioids), heroin, cocaine, or alcohol poisoning (DOH "Alcohol Poisoning" category, ICD-10 X45/X65/Y15: acute alcohol poisoning only, not alcohol-related crashes, falls, or liver disease; not part of DOH's "Any drug" total). Alcohol is on the model page only, not the verification graphic.
- **Sliders:** migration/inflow discouragement, criminalization/enforcement, and how many years past 2025 to project: **4 by default (2026–2029)**, from 1 to a maximum of 10 (2035). Four years stays within about one doubling of the 2018–2025 trend; beyond a few years the lines show what pure compounding implies, not a forecast.
- **Keyboard:** arrow keys move a focused slider; **R** resets the sliders (policies to 0%, horizon to 4 years); the **ⓘ How it works** buttons toggle the "How the Model Works" panel, which starts closed; **Esc** closes it.
- **Copy summary** copies a plain-text report of the current settings and results.

---

## Files in this download

| File                                    |     Needed to run?      | Purpose                                                                                                                                                        |
| --------------------------------------- | :---------------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `washington_overdose_model.html`        |         **yes**         | The page: layout, styles (Tailwind CSS v3, inlined) and the model logic. Open this file.                                                                       |
| `seattle_overdose_model.html`           |           no            | Redirect to `washington_overdose_model.html` (the model's old name), so old links and bookmarks still work.                                                    |
| `chart.umd.min.js`                      | **yes** (for the chart) | Chart.js 4.5.1, a local copy, so the chart works offline. Without it, the numbers and table still work.                                                        |
| `math-utils.js`                         |         **yes**         | Doubling-time / half-life math (`MathUtils.Td`, `MathUtils.DblPredict`), ported from the author's C# utilities.                                              |
| `overdose-data.js`                      |         **yes**         | The observed 2018–2025 data (2025 preliminary) and helper functions.                                                                                                              |
| `time2doubleequations-dark.gif`         |      shown in page      | Diagram of the doubling-time and half-life equations.                                                                                                          |
| `Washington_Overdose_death_2018-25.gif` |      shown in page      | Verification graphic: the 2018–2024 DOH counts by substance plus a 2025 compounding estimate (not DOH data), with a linear chart and a natural-log (ln) chart. |
| `Washington_Overdose_death_2018-25.png` |           no            | Verification graphic, higher-resolution PNG; not needed to run.                                                                                                |
| `Washington_Overdose_death_2018-25.pdf` |           no            | Verification graphic, printable PDF; not needed to run.                                                                                                        |
| `LICENSE.txt`                           |          legal          | Full text of the GNU Affero General Public License v3.0.                                                                                                       |
| `README.md`                             |          docs           | This file.                                                                                                                                                     |
| `model-assets.md`                       |          docs           | Short notes for maintainers.                                                                                                                                   |

Total size is about 1.8 MB unzipped (about 1.5 MB zipped).

---

## Troubleshooting

| What you see                                                                                | Cause and fix                                                                                                                                                                                                                                                      |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Red banner **"Some model files could not be loaded: …"**                                    | The page can't find its supporting files. Extract the whole zip first (don't open the page from inside the zip), keep all files in **one folder**, and open the `.html` from that folder.                                                                          |
| Banner says only `chart.umd.min.js` is missing; there's no chart, but the numbers work      | Put `chart.umd.min.js` back next to the `.html` (re-download if needed).                                                                                                                                                                                           |
| A message says the model **needs JavaScript**, or nothing changes when you move the sliders | JavaScript is blocked for this page. Script-blocking extensions (NoScript, uBlock Origin's "block scripts" mode, etc.) or a work/school browser policy can block it for files opened from disk. Allow scripts for this page and reload, or open a hosted copy if you have one. |
| **Copy summary** shows a pop-up with the text instead of copying                            | The browser blocked clipboard access (some browsers do over plain `http://`). Select and copy the text from the pop-up, or open the file directly from disk or over `https://`.                                                                                    |
| Pictures don't show                                                                        | The `.gif` files aren't next to the `.html`. Re-extract the zip.                                                                                                                                                                                                   |
| The page opened in a text editor or shows code                                              | Right-click the `.html` → **Open with** → a web browser.                                                                                                                                                                                                           |
| Fonts look slightly different on different computers                                        | Normal. The page uses each computer's built-in system fonts and downloads nothing.                                                                                                                                                                                 |

**Optional local web server.** You never need one, but if you prefer `http://` (for example, to test embedding), run this in the folder and open <http://localhost:8000/washington_overdose_model.html>:

```bash
python3 -m http.server 8000        # Windows: py -m http.server 8000
```

---

## Sharing and exporting

- **Share the model:** send the whole `washington-overdose-model-standalone.zip`, not just the `.html`, or share the online link.
- **Share your results:** click **Copy summary** and paste the text into an email, document or post.
- **Save a snapshot:** use the browser's **Print → Save as PDF**; turn on **Background graphics** to keep the dark theme. You can also take a screenshot: Windows Win+Shift+S, macOS Cmd+Shift+4, ChromeOS Ctrl+Shift+Show windows, Linux PrtSc.
- **Offline:** everything works offline. Only the external links (the GNU license page and the WA Department of Health dashboard) need internet.

---

## What the model does (assumptions)

This is a simplified illustrative model. The policy effects are **assumptions chosen for illustration, not measured effects.**

1. **Observed growth rate.** For the selected series, from V1 (start year) to V2 (end year):
   `M = (V2 / V1)^(1/Δt)` is the annual multiplier (CAGR = M − 1), and `r0 = ln(M)` is the continuous growth rate (negative means declining). Doubling time or half-life is `T = ln(2) / |r|` (see `time2doubleequations-dark.gif`).
2. **Projection.** Starts from the **actual 2025 count** (preliminary) and compounds yearly: `deaths(2025 + k) = deaths(2025) × e^(r·k)`. Observed years (2018/2019–2025) are shown as actual data and are never changed by the sliders.
3. **Policy levers** reduce the *growth rate* in proportion to its size, so they work the same way for growing and declining series:

   `r_policy = r0 − |r0| × (a × enforcement + b × migration)`, with each slider from 0 to 1

   | Constant                       | Value                   | Meaning                                                                                                                                       |
   | ------------------------------ | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
   | Lethality / distribution share | 0.65                    | Share of growth attributed to lethality + distribution among existing users (enforcement lever)                                               |
   | Inflow / migration share       | 0.35                    | Share of growth attributed to inflow of new users (migration lever)                                                                           |
   | Maximum shift                  | 1.5                     | Both sliders at 100% shift the rate by 1.5 × \|r0\|                                                                                           |
   | **a** (enforcement)            | **0.975**               | 0.65 × 1.5                                                                                                                                    |
   | **b** (migration)              | **0.525**               | 0.35 × 1.5                                                                                                                                    |
   | Floor                          | 0.5× per year           | The policy line never falls more than 50% a year, unless the baseline already falls faster. The policy rate is never above the baseline rate. |
   | "Stable" threshold             | 12 years                | A doubling time or half-life longer than 12 years (the political horizon) is shown as *stable / homeostasis*.                                 |
   | Projection horizon             | 4 years default, 10 max | Default 2026–2029; the slider stops at 2035 because long runs of pure compounding stop being meaningful.                                      |

   With both sliders at 100%, a growing series reverses into a decline half as fast as it grew: a doubling time of T years becomes a half-life of 2T years. For an already-declining series (for example, heroin), the sliders make the decline faster. For a nearly flat series (for example, oxy over 2018–2025), the sliders have little effect, because they scale with the observed trend.
4. **Lives saved** is the cumulative sum of (baseline − policy) deaths over the projected years, 2026 through the horizon year.

**Example** (page defaults: total deaths, growth period 2018–2025: +13.9%/yr, doubling every 5.33 years; 4-year horizon, projected from the preliminary 2025 actual of 2,932 to 2029):

| Sliders (migration / enforcement) | 2029 baseline | 2029 with policies | Lives saved 2026–2029 | Policy trend                                         |
| --------------------------------- | ------------: | -----------------: | --------------------: | ---------------------------------------------------- |
| 0% / 0%                           |         4,932 |              4,932 |                     0 | +13.9%/yr (doubles in 5.33 yrs)                      |
| 100% / 100%                       |         4,932 |              2,261 |                 6,410 | −6.3%/yr (**half-life** 10.66 yrs)                   |
| 50% / 30%                         |         4,932 |              3,696 |                 2,822 | +6.0%/yr (doubling time 11.98 yrs)                   |

With the 2019–2023 growth period instead (+28.7%/yr, doubling every 2.74 years), the 2029 baseline is 8,053.

Long projections of fast-growing series (for example, fentanyl at +67%/yr) produce very large numbers. That is what pure compounding implies, not a forecast.

---

## Data source

Washington State Department of Health (death certificates), **"Confirmed Overdose Deaths among Washington Residents,"** by year and substance, 2018–2025 (2025 preliminary). Published on the DOH Opioid and Drug Use Data Dashboard: <https://doh.wa.gov/data-and-statistical-reports/washington-tracking-network-wtn/opioids/overdose-dashboard>.

- The values in `overdose-data.js` come from DOH's downloadable dashboard data, <https://doh.wa.gov/sites/default/files/Data/Auto-Uploads/Opioids/Overdose_Downloadable_Deaths.csv> (rows: Statewide, "1 year rolling counts", Overall; file dated **October 12, 2026**). They include DOH's **March 2026 revision of 2024** (total **3,145**, previously a preliminary 3,086; the same 2024 figures appear in DOH's March 19, 2026 statewide presentation, data as of March 16, 2026) and a few small revisions to earlier years (for example, 2023 total 3,459 → 3,458). The full list of changes is in the header comment of `overdose-data.js`.
- **2025 is preliminary**: the sum of DOH's 2025 quarterly counts (2025.1–2025.4) in the same Oct. 12, 2026 file, because the file has no annual 2025 row yet (total **2,932**). DOH suppresses quarterly heroin counts under 10, so the 2025 heroin value (23) is from DOH's March 16, 2026 table. The page marks 2025 with an asterisk; values may change when DOH finalizes them.
- The verification graphic (`Washington_Overdose_death_2018-25.gif`) uses the same revised counts. Its 2025 row is a compounding estimate from the 2018–2024 trend made before DOH's preliminary 2025 counts, not DOH data.
- Column mapping: **Fentanyl** (`fetty`) = synthetic opioids; **Oxy** (`oxy`) = prescription opioids other than fentanyl; **Opiates** (`opiates`) = any opioid; **Meth** (`meth`) = psychostimulants; **Alcohol** (`alcohol`) = alcohol poisoning; **Total** = any drug.
- Substance categories overlap (one death can involve several drugs), so they don't add up to the total.

---

## Using it on your own website

Upload the whole folder (all the files listed above) to any web server, then embed it:

```html
<iframe
    src="/models/compounding-crisis/washington_overdose_model.html"
    title="Washington State Overdose Deaths — Interactive Policy Simulation"
    style="width:100%; height:1050px; border:1px solid #475569; border-radius:12px; background-color:#0f172a;"
    loading="lazy">
</iframe>
<p><a href="/models/compounding-crisis/washington_overdose_model.html" target="_blank" rel="noopener">Open the full interactive model in a new tab →</a></p>
```

- All asset references are bare relative file names, so the page works from any folder or sub-path.
- Inside an iframe the page detects embedding and switches to a more compact layout. The content is taller than 1,050 px, so visitors scroll inside the frame; adjust the height to taste.

---

## License

Copyright (C) 2026 Jillian England.

The model (the HTML page, `math-utils.js`, `overdose-data.js` and the images) is licensed under the **GNU Affero General Public License v3.0 or later** (SPDX: `AGPL-3.0-or-later`). See `LICENSE.txt` and <https://www.gnu.org/licenses/agpl-3.0.html>. If you run a modified version as a public web service, you must make the complete corresponding source available to its users; this bundle is that source.

Third-party components (their own licenses apply):

- **Chart.js 4.5.1** (`chart.umd.min.js`), © Chart.js Contributors, **MIT License**. The notice is kept at the top of the file. <https://www.chartjs.org>
- **Tailwind CSS v3.4.17** (CSS inlined in the `.html`), © Tailwind Labs, **MIT License**. The notice is kept in the inlined CSS. <https://tailwindcss.com>

© 2026 Jillian England. Licensed under the GNU Affero General Public License v3.0 or later (AGPL-3.0-or-later). See `LICENSE.txt`.

---

## For maintainers: editing and rebuilding the bundle

The source of truth is this GitHub repository: <https://github.com/NinerXrayBravoTwoTwo/compound-OD-model>.

- Edit `washington_overdose_model.html` (page and model logic), `overdose-data.js` (data) or `math-utils.js` (math) in any text editor. The model constants are at the top of the main `<script>` in the `.html`; if you change them, update the "What the model does" section above.
- The inlined Tailwind CSS is a purged build. If you use a utility class that isn't defined in the `<style>` block, add it (or regenerate the CSS), or it will silently do nothing.
- After editing, test by opening the `.html` directly from disk and, if you embed it, inside an iframe. Then rebuild the archives.

**Rebuild with the script** (run from the model folder; the archives go to `dist/`):

```bash
sbin/regen-dist.sh          # Linux, macOS, WSL, Git Bash (needs 7z, zip or python3 for the .zip)
```

```powershell
sbin\regen-dist.ps1         # Windows PowerShell / PowerShell 7 (uses 7z if present, else Compress-Archive)
```

Both scripts check that the required files exist and bundle every file at the model root except hidden files, OS junk, backups and old archives (subfolders like `sbin/` and `dist/` are never included). They delete the old archives first and build `dist/washington-overdose-model-standalone.zip` and `.tar.gz` from the same file list, then copy them to the old names `dist/seattle-overdose-model-standalone.zip` / `.tar.gz` so old download links keep working.

**Manual fallback** (from the model folder; also writes into `dist/`):

```powershell
New-Item -ItemType Directory -Force dist | Out-Null
Compress-Archive -Force -DestinationPath dist\washington-overdose-model-standalone.zip -LiteralPath `
    washington_overdose_model.html, seattle_overdose_model.html, chart.umd.min.js, math-utils.js, overdose-data.js, `
    time2doubleequations-dark.gif, Washington_Overdose_death_2018-25.gif, `
    LICENSE.txt, README.md, model-assets.md
```

```bash
mkdir -p dist && rm -f dist/washington-overdose-model-standalone.*
FILES="washington_overdose_model.html seattle_overdose_model.html chart.umd.min.js math-utils.js overdose-data.js \
  time2doubleequations-dark.gif Washington_Overdose_death_2018-25.gif \
  LICENSE.txt README.md model-assets.md"
tar -czf dist/washington-overdose-model-standalone.tar.gz $FILES
zip -9 -X dist/washington-overdose-model-standalone.zip $FILES     # or: 7z a -tzip dist/washington-overdose-model-standalone.zip $FILES
```

The archives in `dist/` are git-ignored (`**/*-standalone.zip`, `**/*-standalone.tar.gz`). Commit only the source files, and publish the `dist/` archives wherever you host the download.

---

*This is a simplified exponential model for illustrative and educational purposes. Real-world outcomes depend on many variables, including drug supply, treatment access and enforcement consistency.*
