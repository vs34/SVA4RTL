#!/bin/bash
# jasper_run.sh — submit files to JasperGold via the SVA4RTL git bridge
# Usage: jasper_run.sh [-v] <file1.sv> [file2.sv ...] <run.tcl>
#   -v  Print full output log for every run (not just failures)
# Works from any directory; uses absolute paths throughout.

set -euo pipefail

REPO="$HOME/function/SVA4RTL"
BRANCH="main"
INPUT_DIR="$REPO/input"
OUTPUT_DIR="$REPO/output"
SCRIPT_DIR="$REPO/script"
RUN_SCRIPT="$SCRIPT_DIR/run_jasper.sh"

POLL_INTERVAL=5
POLL_MAX=60   # 60 x 5s = 5 minutes
VERBOSE=0

# ── 1. Parse arguments ────────────────────────────────────────────────────────

if [ $# -eq 0 ]; then
    echo "Usage: $(basename "$0") [-v] <file1.sv> [file2.svh ...] <run.tcl>"
    echo "  -v  Print full output log for every run (not just failures)"
    echo "  Provide at least one .tcl file and any .sv/.svh source files."
    exit 1
fi

SV_FILES=()
TCL_FILES=()

for ARG in "$@"; do
    if [ "$ARG" = "-v" ]; then
        VERBOSE=1
        continue
    fi
    ABS=$(realpath "$ARG")
    if [ ! -f "$ABS" ]; then
        echo "ERROR: File not found: $ARG"
        exit 1
    fi
    case "$ABS" in
        *.tcl)          TCL_FILES+=("$ABS") ;;
        *.sv|*.svh)     SV_FILES+=("$ABS")  ;;
        *)
            echo "ERROR: Unrecognised file type: $ARG (expected .sv/.svh/.tcl)"
            exit 1
            ;;
    esac
done

if [ ${#TCL_FILES[@]} -eq 0 ]; then
    echo "ERROR: No .tcl file provided."
    exit 1
fi

echo "Source files : ${SV_FILES[*]:-<none>}"
echo "TCL scripts  : ${TCL_FILES[*]}"

# ── 2. Sync with upstream ─────────────────────────────────────────────────────

echo "Syncing with upstream..."
git -C "$REPO" pull --rebase origin "$BRANCH"

# ── 8. Clean input dir locally (no commit/push) ───────────────────────────────

rm -f "$INPUT_DIR"/*
echo "Cleaned local input/ directory."
# ── 4. Copy input files ───────────────────────────────────────────────────────

mkdir -p "$INPUT_DIR"

for F in "${SV_FILES[@]}" "${TCL_FILES[@]}"; do
    echo "Copying: $F -> $INPUT_DIR/"
    cp "$F" "$INPUT_DIR/"
done

# ── 3. Ensure run_jasper.sh exists ────────────────────────────────────────────

mkdir -p "$SCRIPT_DIR"

if [ ! -f "$RUN_SCRIPT" ]; then
    echo "Creating $RUN_SCRIPT ..."
    cat > "$RUN_SCRIPT" << 'EOF'
#!/bin/bash
# run_jasper.sh — runs all TCL files in input/ through JasperGold

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INPUT_DIR="$ROOT_DIR/input"
OUTPUT_DIR="$ROOT_DIR/output"

mkdir -p "$OUTPUT_DIR"

cd "$INPUT_DIR" || exit 1

for TCL_FILE in *.tcl; do
    [ -f "$TCL_FILE" ] || continue
    BASENAME=$(basename "$TCL_FILE" .tcl)
    OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}.txt"

    echo "Running: $TCL_FILE -> $OUTPUT_FILE"
    jg -fpv -batch -tcl "$TCL_FILE" -proj "$ROOT_DIR/jgproject_${BASENAME}" > "$OUTPUT_FILE" 2>&1

    if [ $? -eq 0 ]; then
        echo "PASS: $BASENAME"
        echo "STATUS: PASS" >> "$OUTPUT_FILE"
    else
        echo "FAIL: $BASENAME"
        echo "STATUS: FAIL" >> "$OUTPUT_FILE"
    fi
done

echo "All runs complete. Results in $OUTPUT_DIR/"
EOF
    chmod +x "$RUN_SCRIPT"
fi

# ── 4. Git add, commit, push ──────────────────────────────────────────────────

cd "$REPO"

# Write a timestamp file so there is always a change to commit even if the
# source files are identical to the previous run.
echo "$(date '+%Y-%m-%d_%H:%M:%S')" > "$INPUT_DIR/.run_timestamp"

git add "$INPUT_DIR" "$SCRIPT_DIR"
git commit -m "JasperRun_$(date '+%Y-%m-%d_%H:%M:%S')"
git push origin "$BRANCH"

PUSHED_COMMIT=$(git rev-parse HEAD)
echo "Pushed commit: $PUSHED_COMMIT"
echo "Waiting for Jasper server to pick it up..."

# ── 5. Poll for server response ───────────────────────────────────────────────

COUNT=0
while true; do
    REMOTE_COMMIT=$(git ls-remote origin "$BRANCH" | cut -f1)
    if [ "$REMOTE_COMMIT" != "$PUSHED_COMMIT" ]; then
        echo "Server responded! Remote commit: $REMOTE_COMMIT"
        break
    fi
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $POLL_MAX ]; then
        echo "TIMEOUT: Server did not respond after $((POLL_MAX * POLL_INTERVAL)) seconds."
        exit 1
    fi
    echo "  [$(date '+%H:%M:%S')] No update yet... ($COUNT/$POLL_MAX)"
    sleep "$POLL_INTERVAL"
done

# ── 6. Pull output ────────────────────────────────────────────────────────────

git pull origin "$BRANCH"

# ── 7. Report results ─────────────────────────────────────────────────────────

PASS=0
FAIL=0

for TCL_F in "${TCL_FILES[@]}"; do
    BASENAME=$(basename "$TCL_F" .tcl)
    OUT_FILE="$OUTPUT_DIR/${BASENAME}.txt"

    echo ""
    echo "══════════════════════════════════════"
    echo "  Run: $BASENAME"
    echo "══════════════════════════════════════"

    if [ ! -f "$OUT_FILE" ]; then
        echo "  ERROR: Output file not found: $OUT_FILE"
        FAIL=$((FAIL + 1))
        continue
    fi

    STATUS=$(grep "^STATUS:" "$OUT_FILE" | tail -1 | awk '{print $2}')

    if [ "$STATUS" = "PASS" ]; then
        echo "  RESULT: PASS"
        PASS=$((PASS + 1))
        if [ $VERBOSE -eq 1 ]; then
            echo "--- Output ---"
            cat "$OUT_FILE"
        fi
    else
        echo "  RESULT: FAIL"
        FAIL=$((FAIL + 1))
        echo "--- Output ---"
        cat "$OUT_FILE"
    fi
done

TOTAL=$((PASS + FAIL))
echo ""
echo "══════════════════════════════════════"
echo "  Summary: $PASS/$TOTAL runs passed"
echo "══════════════════════════════════════"


[ $FAIL -eq 0 ]
