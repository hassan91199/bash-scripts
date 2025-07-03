#!/bin/bash

# Usage: git-new-branch [source-branch] [new-branch-name]

# Prompt if source not provided
if [ -z "$1" ]; then
  read -p "Enter source branch (e.g. main, develop): " SOURCE_BRANCH
else
  SOURCE_BRANCH=$1
fi

# Prompt if new branch name not provided
if [ -z "$2" ]; then
  read -p "Enter new branch name (any format): " RAW_NAME
else
  shift
  RAW_NAME="$*"
fi

# Convert to kebab-case lowercase
KEBAB_NAME=$(echo "$RAW_NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')

echo "Creating branch: $KEBAB_NAME from $SOURCE_BRANCH"

# Checkout source
git checkout "$SOURCE_BRANCH" || exit 1

# Create and checkout new branch
git checkout -b "$KEBAB_NAME" || exit 1

# Push to origin
git push -u origin "$KEBAB_NAME"
