#!/bin/sh

# Build the disposable Debian image that runs the portable integration test.
set -eu

root="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)"
if docker build --progress=plain --file "$root/.config/dotfiles/tests/Dockerfile.portable" "$@" "$root"
then
	printf '\nPASS: portable Docker integration test\n'
else
	printf '\nFAIL: portable Docker integration test\n' >&2
	exit 1
fi
