#!/bin/bash
# scripts/run_jasper.sh

# Root is wherever the script is called from
ROOT_DIR=$(pwd)
INPUT_DIR="$ROOT_DIR/input"
OUTPUT_DIR="$ROOT_DIR/output"

# Create output dir if it doesn't exist
mkdir -p "$OUTPUT_DIR"

cd input

# Loop through all .tcl files in input folder
for TCL_FILE in *.tcl; do

    BASENAME=$(basename "$TCL_FILE" .tcl)
    OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}.txt"

    echo "Running: $TCL_FILE -> $OUTPUT_FILE"

    jg -fpv -batch -tcl "$TCL_FILE" -proj "$ROOT_DIR/jgproject_${BASENAME}" > "$OUTPUT_FILE" 2>&1

    EXIT_CODE=$?

    if [ $EXIT_CODE -eq 0 ]; then
        echo "PASS: $BASENAME"
        echo "STATUS: PASS" >> "$OUTPUT_FILE"
    else
        echo "FAIL: $BASENAME"
        echo "STATUS: FAIL" >> "$OUTPUT_FILE"
    fi

done

echo "All runs complete. Results in $OUTPUT_DIR/"

