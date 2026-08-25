#!/usr/bin/env bash
set -euo pipefail

if [[ ${1:-} == --run ]]; then
	exec bash ~/.config/tmux/actions.sh run "${2:?missing key}" "${3:?missing pane ID}" "${4:?missing client name}"
	exit
fi

pane_id=${1:?missing pane ID}
client_name=${4:?missing client name}
bindings=$(bash ~/.config/tmux/actions.sh list)

selected=$(printf '%s\n' "$bindings" \
	| fzf --ansi --height 100% --delimiter '\t' --with-nth=1,2 --prompt 'tmux > ' \
		--border-label ' tmux command palette ') || exit 0
key=${selected%%$'\t'*}

# The popup must close before a selected binding can present its own UI.
tmux run-shell -b "sleep 0.1; bash '$0' --run '$key' '$pane_id' '$client_name'"
