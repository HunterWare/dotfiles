#!/bin/bash
# Install the Claude Code statusline on this machine.
#
# What it does:
#   1. Copies statusline.sh into ~/.claude/statusline.sh (executable)
#   2. Copies monthly-usage.sh into ~/.claude/monthly-usage.sh (the
#      background helper that populates the monthly segment cache)
#   3. Merges the statusLine key into ~/.claude/settings.json so Claude
#      Code picks it up (creates the file if missing, preserves other
#      keys if it already exists).
#
# Requirements: bash, jq
# Idempotent: safe to re-run.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$HOME/.claude"
target_script="$target_dir/statusline.sh"
settings="$target_dir/settings.json"

if ! command -v jq >/dev/null 2>&1; then
    echo "error: jq is required (brew install jq / apt install jq / dnf install jq)" >&2
    exit 1
fi

mkdir -p "$target_dir"

install -m 0755 "$here/statusline.sh" "$target_script"
echo "installed: $target_script"

install -m 0755 "$here/monthly-usage.sh" "$target_dir/monthly-usage.sh"
echo "installed: $target_dir/monthly-usage.sh"

# Merge statusLine into settings.json. Use $HOME so the command is portable
# across machines/users (Claude Code runs the command through a shell).
new_status='{"type":"command","command":"bash $HOME/.claude/statusline.sh"}'

if [ -f "$settings" ]; then
    tmp=$(mktemp)
    jq --argjson sl "$new_status" '.statusLine = $sl' "$settings" > "$tmp"
    mv "$tmp" "$settings"
else
    jq -n --argjson sl "$new_status" '{statusLine: $sl}' > "$settings"
fi
echo "updated:   $settings"

echo
echo "Done. Start a new Claude Code session to see the statusline."
