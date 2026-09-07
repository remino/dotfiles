#!/usr/bin/env zsh

emulate -LR zsh
setopt errexit nounset pipefail

root="$(git -C "${0:A:h}" rev-parse --show-toplevel)"
zshrc="$root/.config/zsh/base/zshrc"

typeset -g INTRO_TEST_HAS_FIGLET=0
typeset -g INTRO_TEST_HAS_LOLCAT=0

unset INTRO_LOLCAT INTRO_FIGLET INTRO_FONT INTRO_TEXT INTRO_COMMAND IDBANNER_SEED

_exists() {
	case "$1" in
	figlet) return $(( ! INTRO_TEST_HAS_FIGLET )) ;;
	lolcat) return $(( ! INTRO_TEST_HAS_LOLCAT )) ;;
	*) command -v "$1" > /dev/null 2>&1 ;;
	esac
}

whoami() { print -r -- test-user }
hostname() { print -r -- test-host }

figlet() {
	[ "$1" = -f ] || return 1
	[ "$2" = good ] || return 1
	[ "${3:-}" = ' ' ] && return
	sed 's/^/figlet:/'
}

lolcat() {
	[ "${1:-}" = -S ] && shift 2
	sed 's/^/lolcat:/'
}

source <(awk '
	/^# Local overrides are loaded/ { printing = 1 }
	printing && /^if _is_demo$/ { exit }
	printing { print }
' "$zshrc")

assert_equal() {
	[ "$1" = "$2" ] || {
		print -u2 -r -- "expected: ${(qqq)2}"
		print -u2 -r -- "actual:   ${(qqq)1}"
		exit 1
	}
}

assert_equal "$INTRO_LOLCAT" 1
assert_equal "$INTRO_FIGLET" 1
assert_equal "${INTRO_FONT[*]}" termino

INTRO_FIGLET=0
INTRO_LOLCAT=0
INTRO_TEXT='plain text'
INTRO_COMMAND=''
assert_equal "$(idbanner)" 'plain text'

INTRO_COMMAND='print -n command-text'
assert_equal "$(idbanner)" 'command-text'

INTRO_COMMAND=false
INTRO_TEXT=''
assert_equal "$(idbanner)" $'test-user@\ntest-host'

INTRO_TEST_HAS_FIGLET=1
INTRO_FIGLET=1
INTRO_FONT=( unavailable )
INTRO_TEXT='font fallback'
assert_equal "$(idbanner)" 'font fallback'

INTRO_FONT=( good )
INTRO_TEST_HAS_LOLCAT=1
INTRO_LOLCAT=1
INTRO_TEXT='rendered'
INTRO_COMMAND=''
IDBANNER_SEED=42
assert_equal "$(idbanner)" 'lolcat:figlet:rendered'

print -r -- 'zsh intro tests passed'
