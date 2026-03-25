#!/bin/bash

WORK_DIR="/path/to/workdir"
BRANCH="main"
LAST_COMMIT=""

cd "$WORK_DIR"

while true; do
    # Check upstream commit
    CURRENT_COMMIT=$(git ls-remote origin $BRANCH | cut -f1)

    if [ "$CURRENT_COMMIT" != "$LAST_COMMIT" ]; then
        echo "New commit detected: $CURRENT_COMMIT"

        # Pull latest code
        git pull origin $BRANCH

        # Loop through all .sh files in scripts folder
        for SCRIPT in scripts/*.sh; do
            if [ -f "$SCRIPT" ]; then
                echo "Running: $SCRIPT"
                bash "$SCRIPT"
                echo "Done: $SCRIPT"
            fi
        done

        # Add everything
        git add .

        # Commit with timestamp
        TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
        git commit -m "Server_$TIMESTAMP"

        # Push
        git push origin $BRANCH

        LAST_COMMIT="$CURRENT_COMMIT"
        echo "Cycle done at $TIMESTAMP"
    fi

    sleep 30
done
