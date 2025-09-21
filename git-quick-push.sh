#!/bin/bash

# Go to your repo directory (optional if already inside repo)
# cd /path/to/your/repo

# Get current timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Add all changes
git add .

# Commit with timestamp message
git commit -m "Updated $timestamp"

# Push to current branch
git push
