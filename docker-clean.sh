#!/bin/bash
set -euo pipefail

# Function to run a step with prompt and error handling
run_step() {
    local description="$1"
    local command="$2"

    echo ""
    read -p "➡️  Do you want to ${description}? (y/n): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "⏳ Running: $command"
        if eval "$command"; then
            echo "✅ Successfully completed: $description"
        else
            echo "❌ Failed: $description"
        fi
    else
        echo "⏩ Skipped: $description"
    fi
}

echo "🔧 Docker Cleanup Script"
echo "========================"

# Step 1: Remove all containers
run_step "remove all containers" \
    "docker container rm -f \$(docker container ls -aq) 2>/dev/null || true"

# Step 2: Remove all images
run_step "remove all images" \
    "docker image rm -f \$(docker image ls -aq) 2>/dev/null || true"

# Step 3: Remove all volumes
run_step "remove all volumes" \
    "docker volume rm -f \$(docker volume ls -q) 2>/dev/null || true"

# Step 4: Remove all custom networks (keep bridge, host, none)
run_step "remove all custom networks" \
    "docker network rm \$(docker network ls -q | grep -v 'bridge\\|host\\|none') 2>/dev/null || true"

# Step 5: Prune builder cache
run_step "prune docker builder cache" \
    "docker builder prune -af"

echo ""
echo "🎉 Docker cleanup steps finished!"
