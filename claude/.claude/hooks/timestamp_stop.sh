#!/usr/bin/env bash
# Stop hook: verify the assistant's FINAL response begins with a timestamp in
# M/D/YY H:MMa/p form (per ~/.claude/CLAUDE.md). If not, block so the model
# redoes it with the prefix. Paired with timestamp_reminder.sh.
#
# Claude Code streams one response as MANY assistant JSONL entries (one text
# block each). The "response" is therefore the contiguous run of main-thread
# assistant entries after the last user/tool entry; the timestamp lives in the
# FIRST non-blank text block of that run — which is what we check.
set -euo pipefail

input=$(cat)

# Avoid infinite loops: if we already blocked once this stop cycle, let it pass.
active=$(printf '%s' "$input" | jq -r '.stop_hook_active // false')
[ "$active" = "true" ] && exit 0

tp=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
[ -z "$tp" ] || [ ! -f "$tp" ] && exit 0

# First non-blank text block of the final main-thread assistant run.
first=$(jq -rs '
  [ .[] | select(.isSidechain != true) ] as $main
  | ( $main | to_entries
      | map(select(.value.type != "assistant"))
      | (last // {key: -1}) | .key ) as $boundary
  | $main[ ($boundary + 1) : ]
  | map(.message.content[]? | select(.type == "text") | .text)
  | map(select(. != null and test("\\S")))
  | .[0] // ""
' "$tp" 2>/dev/null || printf '')

# Nothing to check (turn ended on a tool call / no final text) -> allow.
[ -z "$first" ] && exit 0

# Timestamp pattern: e.g. 7/20/26 3:41p, optionally wrapped in markdown bold
# (**…**) or bold-underscore (__…__) per ~/.claude/CLAUDE.md.
if printf '%s' "$first" | grep -qE '^(\*\*|__)?[0-9]{1,2}/[0-9]{1,2}/[0-9]{2} [0-9]{1,2}:[0-9]{2}[ap]'; then
  exit 0
fi

jq -n '{
  decision: "block",
  reason: "Your response must begin with a timestamp in M/D/YY H:MMa/p format (e.g. 7/20/26 3:41p) per ~/.claude/CLAUDE.md. Prepend it, then repeat your response."
}'
exit 0
