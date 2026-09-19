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
	state=disabled
	if [ -r "$state_file" ]; then
		IFS= read -r state < "$state_file" || true
	fi
	[ "$state" = enabled ] && printf '%s\n' enabled || printf '%s\n' disabled
}

set_timeout() {
	timeout=$1
	target_session=${2:-}
	if [ -n "$target_session" ]; then
		tmux -S "$socket" set-option -t "$target_session" lock-after-time "$timeout"
	else
		tmux -S "$socket" set-option -g lock-after-time "$timeout"
	fi
}

apply_state() {
	if [ "$1" = disabled ]; then
		timeout=0
	else
		timeout=$enabled_after
	fi
	set_timeout "$timeout"
	tmux -S "$socket" list-sessions -F '#{session_id}' | while IFS= read -r target_session; do
		set_timeout "$timeout" "$target_session"
	done
}

case "$mode" in
	apply)
		apply_state "$(saved_state)"
		;;
	toggle)
		current_after="$(tmux -S "$socket" show-options -g -v lock-after-time)"
		if [ "$current_after" -eq 0 ]; then
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
