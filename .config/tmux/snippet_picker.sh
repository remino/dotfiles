#!/usr/bin/env bash

set -euo pipefail

pane_id=${1:-${TMUX_PANE:-}}
[[ -n $pane_id ]] || {
  printf '\nSnippet picker error: tmux did not provide a target pane ID.\n\nPress Enter to close.'
  read -r
  exit 1
}
snippets_dir=${SNIPPETS_DIR:-}

fail() {
  printf '\nSnippet picker error: %s\n\nPress Enter to close.' "$1"
  read -r
  exit 1
}

if [[ -z $snippets_dir || ! -d $snippets_dir ]]; then
  fail 'SNIPPETS_DIR is unset or is not a directory.'
fi

selection=$(cd "$snippets_dir" &&
  fd --follow --type f --hidden --exclude .git . |
    fzf --prompt='Snippets> ' --height=100% --reverse \
      --expect=ctrl-y,ctrl-e \
      --header='enter: paste   ctrl-y: copy   ctrl-e: edit' \
      --preview='bat --style=plain --color=always --line-range :200 -- {} 2>/dev/null || sed -n "1,200p" -- {}') || exit 0

action=${selection%%$'\n'*}
selected_file=${selection#*$'\n'}
if [[ $selected_file == "$selection" ]]; then
  # fzf versions without an --expect action output only the selected file.
  selected_file=$selection
  action=''
fi
[[ -n $selected_file ]] || exit 0

snippet_file="$snippets_dir/$selected_file"

case "$action" in
  ctrl-y)
    tmux load-buffer -- "$snippet_file" || fail "Could not buffer: $selected_file"
    tmux display-message -d 5000 -t "$pane_id" "Buffered snippet: $selected_file"
    ;;
  ctrl-e)
    printf -v quoted_file '%q' "$snippet_file"
    window_name=${selected_file##*/}
    window_name=${window_name%.*}
    [[ -n $window_name ]] || window_name=${selected_file##*/}
    target_window=$(tmux display-message -p -t "$pane_id" '#{window_id}') ||
      fail "Could not resolve the originating window."
    tmux new-window -a -n "$window_name" -t "$target_window" \
      "exec ${EDITOR:-vim} $quoted_file" ||
      fail "Could not open an editor window for: $selected_file"
    ;;
  '')
    tmux load-buffer -b snippets-picker -- "$snippet_file" ||
      fail "Could not read: $selected_file"
    tmux paste-buffer -b snippets-picker -d -t "$pane_id" ||
      fail "Could not paste into pane $pane_id"
    tmux display-message -d 5000 -t "$pane_id" "Pasted snippet: $selected_file"
    ;;
  *)
    fail "Unsupported picker action: $action"
    ;;
esac
