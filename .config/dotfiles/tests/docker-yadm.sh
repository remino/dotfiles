#!/bin/sh

# Build a clean Linux home and verify a real yadm checkout of this repository.
set -eu

root="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)"
if docker build --progress=plain --file "$root/.config/dotfiles/tests/Dockerfile.yadm" "$@" "$root"
then
	printf '\nPASS: yadm Docker integration test\n'
else
	printf '\nFAIL: yadm Docker integration test\n' >&2
	exit 1
fi
