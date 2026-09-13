#!/bin/sh

set -eu

socket=${1:?missing tmux socket path}
shell_path=${TMUX_SHELL:-}

if [ -z "$shell_path" ]; then
	shell_path="$(command -v zsh 2>/dev/null || true)"
fi

[ -n "$shell_path" ] && [ -x "$shell_path" ] || exit 0
tmux -S "$socket" set-option -g default-shell "$shell_path"
