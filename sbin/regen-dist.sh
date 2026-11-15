#!/bin/bash
#
# Regenerate the standalone distribution archives for this model:
#   dist/washington-overdose-model-standalone.tar.gz
#   dist/washington-overdose-model-standalone.zip
# plus identical copies under the legacy names dist/seattle-overdose-model-standalone.{tar.gz,zip},
# so old download links keep working (the model was renamed from seattle_overdose_model.html).
#
# Run from anywhere (the script finds the model root, one level above sbin/):
#   sbin/regen-dist.sh            (from the model root)
#   ./regen-dist.sh               (from inside sbin/)
#
# Works in bash on Linux, macOS, WSL and Git Bash on Windows.
# If you get "bad interpreter" / "\r" errors after editing on Windows, convert line endings:
#   sed -i 's/\r$//' sbin/regen-dist.sh && chmod +x sbin/regen-dist.sh
#
# Zip tool: uses 7z if installed, otherwise `zip`, otherwise python3 (one of these is required).
# Archives are written to dist/ (git-ignored via **/*-standalone.* in the repo .gitignore).

set -euo pipefail

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MODEL_ROOT="$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )"
cd "$MODEL_ROOT"

NAME="washington-overdose-model-standalone"
LEGACY_NAME="seattle-overdose-model-standalone"   # old archive name; kept as a copy for old links
# seattle_overdose_model.html is a small redirect stub to washington_overdose_model.html (old links/bookmarks).
REQUIRED=(washington_overdose_model.html seattle_overdose_model.html chart.umd.min.js math-utils.js overdose-data.js
          time2doubleequations-dark.gif Washington_Overdose_death_2018-25.gif
          LICENSE.txt README.md)

echo "==> Working from model root: $MODEL_ROOT"

for f in "${REQUIRED[@]}"; do
    [[ -f "$f" ]] || { echo "ERROR: required file missing: $f" >&2; exit 1; }
done

# One pass, cached: every regular file at the model root, except hidden files,
# OS/editor junk and previously built archives. Subfolders (sbin/, dist/) are never included.
files=()
while IFS= read -r f; do
    files+=("$f")
done < <(find . -maxdepth 1 -type f \
            ! -name '.*' ! -name 'Thumbs.db' ! -name 'desktop.ini' \
            ! -name '*.zip' ! -name '*.tar.gz' ! -name '*.tgz' \
            ! -name '*~' ! -name '*.bak' ! -name '*.swp' ! -name '*.tmp' \
            | sed 's|^\./||' | LC_ALL=C sort)

echo "Files that will be included in the distribution:"
printf '  %s\n' "${files[@]}"
echo

mkdir -p dist
# Start fresh: 7z/zip "add" would otherwise update an existing archive and keep stale entries.
rm -f "dist/$NAME.tar.gz" "dist/$NAME.zip" "dist/$LEGACY_NAME.tar.gz" "dist/$LEGACY_NAME.zip"

echo "==> Building dist/$NAME.tar.gz"
tar -czf "dist/$NAME.tar.gz" "${files[@]}"

echo "==> Building dist/$NAME.zip"
if command -v 7z >/dev/null 2>&1; then
    7z a -tzip -mx=9 "dist/$NAME.zip" "${files[@]}" >/dev/null
    echo "    (zip built with 7z)"
elif command -v zip >/dev/null 2>&1; then
    zip -9 -X -q "dist/$NAME.zip" "${files[@]}"
    echo "    (zip built with zip)"
elif command -v python3 >/dev/null 2>&1; then
    python3 - "dist/$NAME.zip" "${files[@]}" <<'PY'
import sys, zipfile
out, names = sys.argv[1], sys.argv[2:]
with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as z:
    for n in names:
        z.write(n, arcname=n)
PY
    echo "    (zip built with python3)"
else
    echo "ERROR: no zip tool found. Install 7-Zip (7z), zip, or python3 and re-run." >&2
    exit 1
fi

echo "==> Copying to legacy names (dist/$LEGACY_NAME.*) so old download links keep working"
cp -f "dist/$NAME.tar.gz" "dist/$LEGACY_NAME.tar.gz"
cp -f "dist/$NAME.zip" "dist/$LEGACY_NAME.zip"

echo
echo "==> Done:"
ls -l "dist/$NAME.tar.gz" "dist/$NAME.zip" "dist/$LEGACY_NAME.tar.gz" "dist/$LEGACY_NAME.zip"
echo
echo "Remember:"
echo "  • The archives are in dist/ and are git-ignored; commit only the source files."
echo "  • Re-run this script whenever you change any file at the model root."
echo "  • chart.umd.min.js, math-utils.js, overdose-data.js and the images must stay next to the .html."
