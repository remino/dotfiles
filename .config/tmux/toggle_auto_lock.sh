#!/bin/sh

set -eu

mode=${1:?missing mode}
socket=${2:?missing tmux socket path}
client=${3:-}
enabled_after=300
state_root=${XDG_STATE_HOME:-"$HOME/.local/state"}
state_dir="$state_root/tmux"
state_file="$state_dir/autolock"

saved_state() {
	state=enabled
	if [ -r "$state_file" ]; then
		IFS= read -r state < "$state_file" || true
	fi
	[ "$state" = disabled ] && printf '%s\n' disabled || printf '%s\n' enabled
}

apply_state() {
	if [ "$1" = disabled ]; then
		tmux -S "$socket" set-option -g lock-after-time 0
	else
		tmux -S "$socket" set-option -g lock-after-time "$enabled_after"
	fi
}

case "$mode" in
	apply)
		apply_state "$(saved_state)"
		;;
	toggle)
		if [ "$(tmux -S "$socket" show-options -gv lock-after-time)" -eq 0 ]; then
			state=enabled
			message="Automatic lock enabled (5 minutes)"
		else
			state=disabled
			message="Automatic lock disabled"
		fi
		mkdir -p "$state_dir"
		printf '%s\n' "$state" > "$state_file"
		apply_state "$state"
		[ -z "$client" ] || tmux -S "$socket" display-message -c "$client" "$message"
		;;
	*)
		printf 'Unknown automatic-lock mode: %s\n' "$mode" >&2
		exit 2
		;;
esac
