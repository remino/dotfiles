#!/bin/sh

pane_id=${1:?missing pane ID}
session_id=${2:?missing session ID}
pane_path=${3:?missing pane path}

action=$(printf '%s\n' \
  'new-window	New window at the current path' \
  'split-horizontal	Split left and right' \
  'split-vertical	Split top and bottom' \
  'toggle-zoom	Zoom or unzoom the current pane' \
  'previous-window	Go to the previous window' \
  'next-window	Go to the next window' \
  'tmux-fzf	Open tmux-fzf (K)' \
  'window-tree	Open the window tree (w)' \
  'session-tree	Open the session tree (s)' \
  'sesh	Open the sesh picker (e)' \
  'copy-mode	Enter copy mode' \
  'toggle-status	Show or hide the status rows' \
  'reload-config	Reload tmux.conf' | \
  fzf --ansi --delimiter '\t' --with-nth=2 --prompt 'tmux > ' \
    --border-label ' tmux command palette ' | cut -f1) || exit 0

case "$action" in
  new-window)
    tmux new-window -t "$session_id" -c "$pane_path"
    ;;
  split-horizontal)
    tmux split-window -h -t "$pane_id" -c "$pane_path"
    ;;
  split-vertical)
    tmux split-window -t "$pane_id" -c "$pane_path"
    ;;
  toggle-zoom)
    tmux resize-pane -Z -t "$pane_id"
    ;;
  previous-window)
    tmux previous-window -t "$session_id"
    ;;
  next-window)
    tmux next-window -t "$session_id"
    ;;
  tmux-fzf)
    tmux run-shell -b '/Users/remi/.config/tmux/plugins/tmux-fzf/main.sh'
    ;;
  window-tree)
    tmux choose-tree -Zw
    ;;
  session-tree)
    tmux choose-tree -Zs
    ;;
  sesh)
    tmux run-shell -b 'sh /Users/remi/.config/tmux/sesh_picker.sh'
    ;;
  copy-mode)
    tmux copy-mode -t "$pane_id"
    ;;
  toggle-status)
    tmux if-shell -F '#{==:#{status},off}' 'set status 2' 'set status off'
    ;;
  reload-config)
    tmux source-file ~/.config/tmux/tmux.conf
    tmux display-message 'Config reloaded'
    ;;
esac
