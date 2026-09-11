#!/bin/sh
# Claude Code status line - mirrors p10k lean prompt style
# Elements: user@host  dir  [git branch +/-]  |  model  context%

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // empty')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty')
# Extract workspace folder name only
folder_name="${cwd##*/}"

sep=" \033[2m|\033[0m "

segments="📁 \033[36m${folder_name}\033[0m"

# Model display
if [ -n "$model" ]; then
    segments="${segments}${sep}🤖 \033[34m${model}\033[0m"
fi

# Context usage indicator
if [ -n "$used_pct" ]; then
    used_int=$(printf "%.0f" "$used_pct" 2>/dev/null || echo "$used_pct" | cut -d. -f1)
    if [ "$used_int" -ge 75 ] 2>/dev/null; then
        segments="${segments}${sep}\033[31m[ctx:${used_int}%]\033[0m"
    elif [ "$used_int" -ge 50 ] 2>/dev/null; then
        segments="${segments}${sep}\033[33m[ctx:${used_int}%]\033[0m"
    else
        segments="${segments}${sep}[ctx:${used_int}%]"
    fi
fi

# Session duration (h:mm), low resolution so it doesn't update every second
if [ -n "$duration_ms" ] && [ "$duration_ms" -gt 0 ] 2>/dev/null; then
    total_min=$((duration_ms / 60000))
    hh=$((total_min / 60))
    mm=$((total_min % 60))
    duration_str=$(printf '%d:%02d' "$hh" "$mm")
    segments="${segments}${sep}🕐 ${duration_str}"
fi

# Lines added/removed
if [ -n "$lines_added" ] || [ -n "$lines_removed" ]; then
    segments="${segments}${sep}\033[32m+${lines_added:-0}\033[0m/\033[31m-${lines_removed:-0}\033[0m"
fi

printf '%b' "$segments"
