#!/bin/bash

# A simple script to add, commit, and push changes with a timestamped message

# Exit immediately if a command fails
set -e

# Commit message with timestamp
COMMIT_MESSAGE="Update $(date '+%Y-%m-%d %H:%M:%S')"

# Stage all changes, commit, and push
git add .
git commit -m "$COMMIT_MESSAGE"
git push

echo "✅ Changes pushed with commit message: $COMMIT_MESSAGE"
