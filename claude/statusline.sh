#!/bin/bash
# Claude Code status line: model, context usage, session/monthly tokens & cost.
# Schema verified against CC stdin (v2.1.111). Monthly comes from cache file
# refreshed by ~/.claude/monthly-usage.sh (kicked off here when stale).
# Colors: Dracula theme palette (https://draculatheme.com)

input=$(cat)

# Snapshot last stdin for future schema diffs.
debug="$HOME/.claude/statusline-debug"
mkdir -p "$debug"
printf '%s\n' "$input" > "$debug/last.json"

q() { printf '%s' "$input" | jq -r "$1"; }

# ---------------------------------------------------------------------------
# Dracula theme ANSI 24-bit color helpers
# ---------------------------------------------------------------------------
# Foreground: #f8f8f2   Comment/muted: #6272a4   Purple: #bd93f9
# Cyan: #8be9fd         Green: #50fa7b            Orange: #ffb86c
# Yellow: #f1fa8c       Red: #ff5555
# ---------------------------------------------------------------------------
_fg()    { printf '\033[38;2;%s;%s;%sm' "$1" "$2" "$3"; }
_reset() { printf '\033[0m'; }

C_FG=$(_fg 248 248 242)    # Dracula Foreground  #f8f8f2
C_DIM=$(_fg  98 114 164)   # Dracula Comment     #6272a4
C_PUR=$(_fg 189 147 249)   # Dracula Purple      #bd93f9
C_CYN=$(_fg 139 233 253)   # Dracula Cyan        #8be9fd
C_GRN=$(_fg  80 250 123)   # Dracula Green       #50fa7b
C_ORG=$(_fg 255 184 108)   # Dracula Orange      #ffb86c
C_YEL=$(_fg 241 250 140)   # Dracula Yellow      #f1fa8c
C_RED=$(_fg 255  85  85)   # Dracula Red         #ff5555
C_RST=$(_reset)

SEP="${C_DIM} | ${C_RST}"

# ---------------------------------------------------------------------------

model=$(q '.model.display_name // .model.id // "Claude"')
# "Opus 4.7 (1M context)" -> "Opus 4.7 (1M ctx)"
model="${model//1M context/1M ctx}"

ctx_size=$(q '.context_window.context_window_size // 0')
used_pct=$(q '.context_window.used_percentage // 0')
cur_in=$(q   '.context_window.current_usage.input_tokens // 0')
cur_cw=$(q   '.context_window.current_usage.cache_creation_input_tokens // 0')
cur_cr=$(q   '.context_window.current_usage.cache_read_input_tokens // 0')
sess_in=$(q  '.context_window.total_input_tokens // 0')
sess_out=$(q '.context_window.total_output_tokens // 0')
cost_usd=$(q '.cost.total_cost_usd // empty')
exceeds=$(q  '.exceeds_200k_tokens // false')

# Monthly: read from cache; trigger background refresh if stale.
monthly_cache="$HOME/.claude/statusline-cache/monthly.json"
month_now=$(date -u +%Y-%m)
monthly_tok=""; monthly_cost=""
need_refresh=1
if [ -f "$monthly_cache" ]; then
    cached_month=$(jq -r '.month // ""'      "$monthly_cache" 2>/dev/null)
    cached_at=$(jq   -r '.computed_at // 0'  "$monthly_cache" 2>/dev/null)
    monthly_tok=$(jq -r '.tokens // 0'       "$monthly_cache" 2>/dev/null)
    monthly_cost=$(jq -r '.cost // 0'        "$monthly_cache" 2>/dev/null)
    age=$(( $(date +%s) - ${cached_at:-0} ))
    [ "$cached_month" = "$month_now" ] && [ "$age" -lt 300 ] && need_refresh=0
fi
if [ "$need_refresh" -eq 1 ]; then
    nohup "$HOME/.claude/monthly-usage.sh" >/dev/null 2>&1 &
    disown 2>/dev/null || true
fi

fmt_k() { awk -v n="$1" 'BEGIN {
    n += 0
    if (n >= 1000000) printf "%.1fM", n/1000000
    else if (n >= 1000) printf "%.1fK", n/1000
    else printf "%d", n
}'; }
fmt_usd() { awk -v c="$1" 'BEGIN { printf "$%.2f", c }'; }

cur_total=$(( cur_in + cur_cw + cur_cr ))
sess_total=$(( sess_in + sess_out ))

# Model name — Purple (primary element)
out="${C_PUR}${model}${C_RST}"

if [ "$ctx_size" -gt 0 ] 2>/dev/null; then
    used_int=$(printf "%.0f" "$used_pct")
    # Context color: Green <50%, Orange 50-79%, Red >=80%
    if [ "$used_int" -ge 80 ] 2>/dev/null; then
        ctx_color="$C_RED"
    elif [ "$used_int" -ge 50 ] 2>/dev/null; then
        ctx_color="$C_ORG"
    else
        ctx_color="$C_CYN"
    fi
    out="${out}${SEP}${C_DIM}ctx:${C_RST} ${ctx_color}$(fmt_k "$cur_total")/$(fmt_k "$ctx_size") (${used_int}%)${C_RST}"
fi

if [ "$sess_total" -gt 0 ]; then
    seg="${C_DIM}session:${C_RST} ${C_GRN}$(fmt_k "$sess_total") tok${C_RST}"
    if [ -n "$cost_usd" ] && [ "$cost_usd" != "null" ]; then
        seg="${seg} ${C_DIM}(${C_FG}$(fmt_usd "$cost_usd")${C_DIM})${C_RST}"
    fi
    out="${out}${SEP}${seg}"
fi

if [ -n "$monthly_tok" ] && [ "$monthly_tok" -gt 0 ] 2>/dev/null; then
    seg="${C_DIM}month:${C_RST} ${C_ORG}$(fmt_k "$monthly_tok") tok${C_RST}"
    if [ -n "$monthly_cost" ] && [ "$monthly_cost" != "0" ] && [ "$monthly_cost" != "null" ]; then
        seg="${seg} ${C_DIM}(${C_FG}$(fmt_usd "$monthly_cost")${C_DIM})${C_RST}"
    fi
    out="${out}${SEP}${seg}"
fi

[ "$exceeds" = "true" ] && out="${out}${SEP}${C_YEL}⚠ >200K${C_RST}"

printf "%s" "$out"
