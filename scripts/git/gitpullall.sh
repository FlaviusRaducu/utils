#!/bin/bash

# Assumes that $start_dir contains only git repos
start_dir=$(pwd)

# Find all git repos within the specified directory and iterate
find "$start_dir" -type d -maxdepth 1 -mindepth 1 | while read -r dir; do
    cd "$dir"

    # Echo the repo path and current branch for clarity
    echo "Updating repo: $dir"
    git pull
    echo "Current branch:":
    git branch
	echo ""

	cd "$start_dir"
done

