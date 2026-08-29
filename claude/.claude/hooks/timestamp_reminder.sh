#!/usr/bin/env bash
# UserPromptSubmit hook: inject the current timestamp (M/D/YY H:MMa/p) so the
# assistant can prefix its reply per ~/.claude/CLAUDE.md. See the paired
# Stop hook (timestamp_stop.sh) which enforces the prefix.
set -euo pipefail

ampm=$(date '+%p' | cut -c1 | tr 'A-Z' 'a-z')   # 'a' or 'p'
ts="$(date '+%-m/%-d/%y %-I:%M')${ampm}"

jq -n --arg ts "$ts" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    additionalContext: ("Response-format reminder: begin your reply with the timestamp " + $ts + " (format M/D/YY H:MMa/p) per ~/.claude/CLAUDE.md.")
  }
}'
