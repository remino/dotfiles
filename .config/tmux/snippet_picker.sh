#!/usr/bin/env bash

set -euo pipefail

pane_id=${1:?missing pane ID}
snippets_dir=${SNIPPETS_DIR:-}

fail() {
  printf '\nSnippet picker error: %s\n\nPress Enter to close.' "$1"
  read -r
  exit 1
}

if [[ -z $snippets_dir || ! -d $snippets_dir ]]; then
  fail 'SNIPPETS_DIR is unset or is not a directory.'
fi

selected_file=$(cd "$snippets_dir" &&
  fd --type f --hidden --exclude .git . |
    fzf --prompt='Snippets> ' --height=100% --reverse \
      --preview='bat --style=plain --color=always --line-range :200 -- {} 2>/dev/null || sed -n "1,200p" -- {}') || exit 0

tmux load-buffer -b snippets-picker -- "$snippets_dir/$selected_file" ||
  fail "Could not read: $selected_file"
tmux paste-buffer -b snippets-picker -d -t "$pane_id" ||
  fail "Could not paste into pane $pane_id"
tmux display-message -d 5000 -t "$pane_id" "Pasted snippet: $selected_file"
