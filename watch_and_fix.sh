#!/bin/bash
# watch_and_fix.sh
# Polls upstream for new commits, re-applies the bind-split fix if needed,
# pushes the fix, then waits for the server to run JasperGold and reports results.

BRANCH="main"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LAST_COMMIT=""
POLL_INTERVAL=15   # seconds between upstream checks
SERVER_WAIT=60     # seconds to wait for server to process and push output

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

# ---------------------------------------------------------------------------
# apply_fix: idempotent - removes bind block from assert files, creates
# separate bind_*.sv files, and updates TCL scripts.
# ---------------------------------------------------------------------------
apply_fix() {
    local changed=0

    for N in 0 1; do
        ASSERT_FILE="$REPO_DIR/input/assert_reset_behavior_${N}.sv"
        BIND_FILE="$REPO_DIR/input/bind_reset_behavior_${N}.sv"
        TCL_FILE="$REPO_DIR/input/run_reset_behavior_${N}.tcl"

        # --- Step 1: strip bind block from assert file ---
        if grep -q "^bind " "$ASSERT_FILE"; then
            log "Stripping bind block from assert_reset_behavior_${N}.sv"
            # Keep only up to and including 'endmodule'
            awk '/^endmodule/{print; found=1; next} !found{print}' "$ASSERT_FILE" > "${ASSERT_FILE}.tmp"
            mv "${ASSERT_FILE}.tmp" "$ASSERT_FILE"
            changed=1
        fi

        # --- Step 2: create bind_*.sv if missing ---
        if [ ! -f "$BIND_FILE" ]; then
            log "Creating $BIND_FILE"
            cat > "$BIND_FILE" <<'BIND_EOF'
bind mbox_ctrl mbox_ctrl_reset_behavior_assert u_mbox_ctrl_reset_behavior_assert (
  .clk(clk),
  .rst_n(rst_n),
  .r_ctrl(r_ctrl),
  .r_cmd(r_cmd),
  .r_irq_mask(r_irq_mask),
  .r_xfer_cnt(r_xfer_cnt),
  .r_src_addr(r_src_addr),
  .r_dst_addr(r_dst_addr),
  .r_lock(r_lock),
  .r_err_code(r_err_code),
  .remaining_q(remaining_q),
  .timeout_q(timeout_q),
  .fifo_cnt(fifo_cnt),
  .fifo_wr_ptr(fifo_wr_ptr),
  .fifo_rd_ptr(fifo_rd_ptr),
  .o_rdata(o_rdata),
  .o_ready(o_ready)
);
BIND_EOF
            # Patch the placeholder N into the filename reference (not needed here,
            # bind files are identical; kept separate for future divergence)
            changed=1
        fi

        # --- Step 3: ensure TCL analyzes the bind file ---
        if ! grep -q "bind_reset_behavior_${N}.sv" "$TCL_FILE"; then
            log "Patching $TCL_FILE to analyze bind_reset_behavior_${N}.sv"
            sed -i.bak "s|analyze -sv09 assert_reset_behavior_${N}.sv|analyze -sv09 assert_reset_behavior_${N}.sv\nanalyze -sv09 bind_reset_behavior_${N}.sv|" "$TCL_FILE"
            rm -f "${TCL_FILE}.bak"
            changed=1
        fi
    done

    return $changed
}

# ---------------------------------------------------------------------------
# check_results: parse output files and report PASS/FAIL per run
# ---------------------------------------------------------------------------
check_results() {
    log "--- JasperGold Results ---"
    local all_pass=1

    for N in 0 1; do
        OUT="$REPO_DIR/output/run_reset_behavior_${N}.txt"
        if [ ! -f "$OUT" ]; then
            log "  run_reset_behavior_${N}: output file not found"
            all_pass=0
            continue
        fi

        if grep -q "^STATUS: PASS" "$OUT"; then
            log "  run_reset_behavior_${N}: PASS"
        else
            all_pass=0
            log "  run_reset_behavior_${N}: FAIL"
            # Print the last relevant error lines
            grep -E "ERROR|STATUS" "$OUT" | tail -10 | while read -r line; do
                log "    $line"
            done
        fi
    done

    if [ "$all_pass" -eq 1 ]; then
        log "All JasperGold runs PASSED."
    else
        log "Some runs still failing - will retry on next commit cycle."
    fi
}

# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------
cd "$REPO_DIR"
log "watch_and_fix.sh started. Polling $BRANCH every ${POLL_INTERVAL}s..."

while true; do
    CURRENT_COMMIT=$(git ls-remote origin "$BRANCH" | cut -f1)

    if [ "$CURRENT_COMMIT" != "$LAST_COMMIT" ]; then
        log "New upstream commit detected: $CURRENT_COMMIT"

        git pull origin "$BRANCH"

        apply_fix
        FIX_CHANGED=$?

        if [ $FIX_CHANGED -ne 0 ] || ! git diff --quiet || ! git diff --staged --quiet; then
            TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')
            git add input/
            git commit -m "Fix_BindSplit_$TIMESTAMP"
            git push origin "$BRANCH"
            log "Fix pushed. Waiting ${SERVER_WAIT}s for server to process..."
            sleep "$SERVER_WAIT"

            # Pull the server's output commit
            git pull origin "$BRANCH"
            check_results
        else
            log "Fix already applied, no changes needed."
            check_results
        fi

        LAST_COMMIT=$(git ls-remote origin "$BRANCH" | cut -f1)
    fi

    sleep "$POLL_INTERVAL"
done
