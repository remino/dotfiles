#!/usr/bin/env bash
set -euo pipefail

list_actions() {
  tmux list-keys -N -T prefix | awk '
    /^C-a[[:space:]]/ {
      key = $2
      $1 = ""; $2 = ""
      sub(/^[[:space:]]+/, "")
      print key "\t" $0
    }'
}

run_bound_command() {
  local key=$1 pane_id=$2 binding command

  binding=$(tmux list-keys -T prefix | awk -v key="$key" '
    $1 == "bind-key" { for (i = 1; i + 2 <= NF; i++) {
      binding_key = $(i + 2)
      sub(/^\\/, "", binding_key)
      if ($i == "-T" && $(i + 1) == "prefix" && binding_key == key) { print; exit }
    }}')
  [[ $binding =~ -T[[:space:]]+prefix[[:space:]]+[^[:space:]]+[[:space:]]+(.+)$ ]] || {
    printf 'No prefix binding found for: %s\n' "$key" >&2
    return 64
  }
  command=${BASH_REMATCH[1]}

  # tmux parses the serialized binding itself. '-' reads the command stream
  # from standard input, so no temporary file or shell evaluation is needed.
  printf 'select-pane -t %s\n%s\n' "$pane_id" "$command" | tmux source-file -
}

run_action() {
  local key=$1 pane_id=$2 client_name=${3:-}

  case "$key" in
    # source-file runs fine from the background palette job, but its message
    # needs an explicit client target.
    C-r)
      tmux source-file ~/.config/tmux/tmux.conf
      tmux display-message -c "$client_name" 'Config reloaded'
      ;;

    # These commands open their own UI after the palette closes.
    w) tmux choose-tree -t "$pane_id" -Zw ;;
    s) tmux choose-tree -t "$pane_id" -Zs ;;
    e) sh ~/.config/tmux/sesh_picker.sh ;;
    K) sh ~/.config/tmux/plugins/tmux-fzf/main.sh ;;

    # A session with no MRU window makes last-window return 1. For the palette,
    # that is a harmless no-op rather than an error.
    Tab|a) tmux last-window -t "$pane_id" 2>/dev/null || true ;;

    *) run_bound_command "$key" "$pane_id" ;;
  esac
}

case "${1:-}" in
  list) list_actions ;;
  run) run_action "${2:?missing key}" "${3:?missing pane ID}" "${4:-}" ;;
  *) printf 'Usage: %s {list|run KEY PANE_ID [CLIENT]}\n' "$0" >&2; exit 64 ;;
esac
