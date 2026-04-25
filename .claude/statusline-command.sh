#!/bin/bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
in_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
out_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
worktree_name=$(echo "$input" | jq -r '.worktree.name // empty')
thinking=$(echo "$input" | jq -r '.thinking.enabled // false')

git_branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
fi

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

task_label=""
transcript=$(echo "$input" | jq -r '.transcript_path // empty')
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  first_prompt=$(jq -rs '[.[] | select(.type == "user")] | first | .message.content | if type == "array" then (map(select(.type == "text")) | first | .text) else . end' "$transcript" 2>/dev/null)
  if [ -n "$first_prompt" ] && [ "$first_prompt" != "null" ]; then
    task_label=$(printf '%.50s' "$first_prompt")
    [ ${#first_prompt} -gt 50 ] && task_label="${task_label}..."
  fi
fi
if [ -z "$task_label" ]; then
  task_label=$(echo "$input" | jq -r '.session_name // empty')
fi

fmt_k() {
  local n=$1
  if [ "$n" -ge 1000 ] 2>/dev/null; then
    printf '%dk' "$((n / 1000))"
  else
    printf '%s' "$n"
  fi
}

parts=()

if [ -n "$model" ]; then
  if [ -n "$effort" ]; then
    parts+=("$(printf '\033[37m%s(%s)\033[0m' "$model" "$effort")")
  else
    parts+=("$(printf '\033[37m%s\033[0m' "$model")")
  fi
fi

if [ -n "$worktree_name" ]; then
  parts+=("$(printf '\033[1;33m[wt:%s]\033[0m' "$worktree_name")")
fi

if [ -n "$cwd" ]; then
  display_dir="${cwd/#$HOME/~}"
  parts+=("$(printf '\033[34m%s\033[0m' "$display_dir")")
fi

if [ -n "$git_branch" ]; then
  parts+=("$(printf '\033[32m[%s]\033[0m' "$git_branch")")
fi

if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  BAR_WIDTH=10
  FILLED=$((used_int * BAR_WIDTH / 100))
  EMPTY=$((BAR_WIDTH - FILLED))
  BAR=""
  [ "$FILLED" -gt 0 ] && printf -v FILL "%${FILLED}s" && BAR="${FILL// /▓}"
  [ "$EMPTY" -gt 0 ] && printf -v PAD "%${EMPTY}s" && BAR="${BAR}${PAD// /░}"
  if [ "$used_int" -ge 80 ]; then
    parts+=("$(printf '\033[31m%s %s%%\033[0m' "$BAR" "$used_int")")
  elif [ "$used_int" -ge 50 ]; then
    parts+=("$(printf '\033[33m%s %s%%\033[0m' "$BAR" "$used_int")")
  else
    parts+=("$(printf '\033[36m%s %s%%\033[0m' "$BAR" "$used_int")")
  fi
fi

if [ -n "$in_tokens" ] && [ -n "$out_tokens" ]; then
  in_fmt=$(fmt_k "$in_tokens")
  out_fmt=$(fmt_k "$out_tokens")
  parts+=("$(printf '\033[36min:%s out:%s\033[0m' "$in_fmt" "$out_fmt")")
fi

if [ "$thinking" = "true" ]; then
  parts+=("$(printf '\033[35mthink\033[0m')")
fi

if [ -n "$cost" ]; then
  cost_fmt=$(printf '$%.4f' "$cost")
  parts+=("$(printf '\033[33m%s\033[0m' "$cost_fmt")")
fi

if [ -n "$duration_ms" ]; then
  mins=$(( duration_ms / 60000 ))
  secs=$(( (duration_ms % 60000) / 1000 ))
  parts+=("$(printf '\033[90m%dm%ds\033[0m' "$mins" "$secs")")
fi

if [ -n "$task_label" ]; then
  parts+=("$(printf '\033[35m\"%s\"\033[0m' "$task_label")")
fi

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
