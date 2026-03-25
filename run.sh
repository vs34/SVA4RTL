#!/bin/bash

WORK_DIR="script"
BRANCH="main"
LAST_COMMIT=""

#cd "$WORK_DIR"
echo "in the DIR"
pwd

while true; do
    # Check upstream commit
    CURRENT_COMMIT=$(git ls-remote origin $BRANCH | cut -f1)

    TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')
    echo "Checkd upstreem at $TIMESTAMP"

    if [ "$CURRENT_COMMIT" != "$LAST_COMMIT" ]; then
        echo "New commit detected: $CURRENT_COMMIT"

        # Pull latest code
        git pull origin $BRANCH

        # Loop through all .sh files in scripts folder
        for SCRIPT in script/*.sh; do
	    echo "wht is happening"
            if [ -f "$SCRIPT" ]; then
                echo "Running: $SCRIPT"
		chmod +x "$SCRIPT"
                bash "$SCRIPT"
                echo "Done: $SCRIPT"
            fi
        done

        # Add everything
        git add .

        # Commit with timestamp
        TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')
        git commit -m "Server_$TIMESTAMP"

        # Push
        git push origin $BRANCH

        LAST_COMMIT="$CURRENT_COMMIT"
        echo "Cycle done at $TIMESTAMP"
    fi

    sleep 10
done
