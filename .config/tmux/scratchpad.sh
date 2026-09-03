#!/usr/bin/env bash

set -euo pipefail

if [[ -z ${SCRATCHPAD_FILE:-} ]]; then
  printf 'Set SCRATCHPAD_FILE before opening the scratchpad.\n' >&2
  exit 1
fi

# EDITOR may include its own flags (for example, "nvim -f"). It is a trusted
# user-configured value, so intentional word splitting is appropriate here.
# shellcheck disable=SC2086
exec ${EDITOR:-vim} "$SCRATCHPAD_FILE"
