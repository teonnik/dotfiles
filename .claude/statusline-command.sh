#!/bin/sh
# Claude Code status line - mirrors p10k lean prompt style
# Elements: user@host  dir  [git branch +/-]  |  model  context%

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
# Extract workspace folder name only
folder_name="${cwd##*/}"

# Context usage indicator
ctx_info=""
if [ -n "$used_pct" ]; then
    used_int=$(printf "%.0f" "$used_pct" 2>/dev/null || echo "$used_pct" | cut -d. -f1)
    if [ "$used_int" -ge 75 ] 2>/dev/null; then
        ctx_info=" \033[31m[ctx:${used_int}%]\033[0m"
    elif [ "$used_int" -ge 50 ] 2>/dev/null; then
        ctx_info=" \033[33m[ctx:${used_int}%]\033[0m"
    else
        ctx_info=" [ctx:${used_int}%]"
    fi
fi

# Model display (shortened)
model_info=""
if [ -n "$model" ]; then
    model_info=" 🤖 \033[34m${model}\033[0m"
fi

printf '%b' "📁 \033[36m${folder_name}\033[0m${model_info}${ctx_info}"
