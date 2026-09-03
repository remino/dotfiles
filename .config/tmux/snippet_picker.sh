#!/usr/bin/env bash

set -euo pipefail

pane_id=${1:?missing pane ID}
snippets_dir=${SNIPPETS_DIR:-}

if [[ -z $snippets_dir || ! -d $snippets_dir ]]; then
  tmux display-message -t "$pane_id" 'Set SNIPPETS_DIR to your snippets repository, then renew tmux environment with prefix-$.'
  exit 0
fi

selected_file=$(cd "$snippets_dir" &&
  fd --type f --hidden --exclude .git . |
    fzf --prompt='Snippets> ' --height=100% --reverse \
      --preview='bat --style=plain --color=always --line-range :200 -- {} 2>/dev/null || sed -n "1,200p" -- {}') || exit 0

tmux load-buffer -b snippets-picker -- "$snippets_dir/$selected_file"
tmux paste-buffer -b snippets-picker -d -t "$pane_id"
tmux display-message -t "$pane_id" "Pasted snippet: $selected_file"
