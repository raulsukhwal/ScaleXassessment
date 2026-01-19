#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_ROOT"

echo "Initializing git repo (if not already)..."
git init

echo "Adding all files..."
git add .

echo "Creating commit..."
git commit -m "chore: initial book library app" || echo "Commit skipped (maybe no changes)."

echo ""
echo "To push to a new remote:"
echo "  git remote add origin <REMOTE_URL>"
echo "  git push -u origin main"
