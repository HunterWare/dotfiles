#!/bin/bash
# Compute current-month Claude Code usage by scanning local session JSONLs
# under ~/.claude/projects/. Writes ~/.claude/statusline-cache/monthly.json
# for statusline.sh to consume. statusline.sh kicks this off in the
# background when its cache is stale (>5 min), so this script does the
# heavy lifting off the render path.
#
# Pricing is per-million-tokens, standard tier; update if Anthropic
# changes rates. Tokens are the sum of input + output + cache-read +
# cache-create (5m and 1h).

set -u

cache_dir="$HOME/.claude/statusline-cache"
cache_file="$cache_dir/monthly.json"
mkdir -p "$cache_dir"

month=$(date -u +%Y-%m)
now=$(date +%s)

find "$HOME/.claude/projects" -name '*.jsonl' -print0 2>/dev/null \
    | xargs -0 -r cat 2>/dev/null \
    | jq -nR --arg prefix "$month" --argjson now "$now" '
        def price(model):
            (model | ascii_downcase) as $m
            | if   $m | contains("opus")   then {i:15, o:75, cr:1.5, c5:18.75, c1:30}
              elif $m | contains("sonnet") then {i:3,  o:15, cr:0.3, c5:3.75,  c1:6}
              elif $m | contains("haiku")  then {i:1,  o:5,  cr:0.1, c5:1.25,  c1:2}
              else                              {i:15, o:75, cr:1.5, c5:18.75, c1:30}
              end;

        reduce (inputs | fromjson? | select(. != null)) as $r (
            {tokens: 0, cost: 0};
            if (($r.timestamp // "") | startswith($prefix))
               and ($r.message.usage != null)
            then
                price($r.message.model // "") as $p
                | $r.message.usage as $u
                | ($u.input_tokens // 0) as $in
                | ($u.output_tokens // 0) as $out
                | ($u.cache_read_input_tokens // 0) as $cr
                | (($u.cache_creation.ephemeral_5m_input_tokens // 0)) as $c5
                | (($u.cache_creation.ephemeral_1h_input_tokens // 0)) as $c1
                | .tokens += ($in + $out + $cr + $c5 + $c1)
                | .cost   += (($in*$p.i + $out*$p.o + $cr*$p.cr + $c5*$p.c5 + $c1*$p.c1) / 1000000)
            else . end
        )
        | { month: $prefix, computed_at: $now, tokens: .tokens, cost: .cost }
    ' > "$cache_file"
