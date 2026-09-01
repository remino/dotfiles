#!/bin/sh

# End-to-end test for .config/dotfiles/bin/portable. It uses only local HTTP and Git
# remotes, so it is safe to run before the public installer URL exists.
set -eu

root="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)"
work="$(mktemp -d "${TMPDIR:-/tmp}/remino-dotfiles-test.XXXXXX")"
server_pid=''

cleanup() {
	[ -z "$server_pid" ] || kill "$server_pid" 2>/dev/null || true
	rm -rf "$work"
}
trap cleanup EXIT HUP INT TERM

command -v git >/dev/null 2>&1
command -v python3 >/dev/null 2>&1
command -v yadm >/dev/null 2>&1

# Build a throwaway remote including the working tree's tracked edits. This
# makes the test exercise an uncommitted launcher change just as CI will test
# the checked-out commit.
git clone --no-hardlinks "$root" "$work/checkout" >/dev/null
if ! git -C "$root" diff --quiet HEAD
then
	git -C "$root" diff --binary HEAD | git -C "$work/checkout" apply
	git -C "$work/checkout" -c user.name='Portable shell test' -c user.email='test@example.invalid' commit -am 'Test working tree' >/dev/null
fi
git -C "$work/checkout" tag portable-test
git clone --bare "$work/checkout" "$work/dotfiles.git" >/dev/null
git -C "$work/dotfiles.git" fetch "$work/checkout" 'refs/tags/portable-test:refs/tags/portable-test' >/dev/null
cp "$(command -v yadm)" "$work/yadm"
if command -v shasum >/dev/null 2>&1; then
	yadm_sha256="$(shasum -a 256 "$work/yadm" | awk '{print $1}')"
else
	yadm_sha256="$(sha256sum "$work/yadm" | awk '{print $1}')"
fi
mkdir -p "$work/tmp"

python3 -u -m http.server 0 --bind 127.0.0.1 --directory "$root" >"$work/http.log" 2>&1 &
server_pid="$!"
sleep 1
port="$(sed -n 's/.*port \([0-9][0-9]*\).*/\1/p' "$work/http.log" | head -n 1)"
[ -n "$port" ] || { cat "$work/http.log" >&2; exit 1; }

fake_home="$work/real-home"
mkdir -p "$fake_home"
printf 'keep\n' > "$fake_home/sentinel"

installer_url="${INSTALLER_URL:-http://127.0.0.1:$port/.config/dotfiles/bin/portable}"
curl -fsS "$installer_url" -o "$work/portable"
# shellcheck disable=SC2016 # $HOME must expand inside the launched Zsh.
output="$(printf 'alias anchor\ntest -f "$HOME/.gnupg/gpg.conf" && print template-rendered\n(( $+functions[_fallback_prompt_precmd] )) && [[ " ${precmd_functions[*]} " == *" _fallback_prompt_precmd "* ]] && [[ "$PS1" == *"❯"* ]] && print fallback-prompt || true\nexit\n' | \
	HOME="$fake_home" TMPDIR="$work/tmp" \
	DOTFILES_REPOSITORY="file://$work/dotfiles.git" \
	DOTFILES_NVIM_REPOSITORY="file://$work/dotfiles.git" \
	DOTFILES_YADM_URL="file://$work/yadm" \
	DOTFILES_YADM_SHA256="$yadm_sha256" \
	bash "$work/portable" --ref portable-test)"
assert_output() {
	printf '%s\n' "$output" | grep "$@" >/dev/null || {
		printf '%s\n' 'portable output did not match:' >&2
		printf '%s\n' "$output" >&2
		exit 1
	}
}
assert_output -F "anchor='anchor=\$PWD'"
assert_output -F 'template-rendered'
assert_output -F 'fallback-prompt'
assert_output -F 'curl -fsSL https://remino.net/run/shell | bash'
[ "$(cat "$fake_home/sentinel")" = keep ]
[ ! -e "$fake_home/.zshrc" ]
[ -z "$(find "$work/tmp" -maxdepth 1 -name 'remino-dotfiles.*' -print -quit)" ]

# shellcheck disable=SC2016 # $XDG_CONFIG_HOME must expand inside the launched Zsh.
worktree_output="$(printf 'test -f "$XDG_CONFIG_HOME/nvim/.git/config" && print worktree-snapshot\nexit\n' | \
	TMPDIR="$work/tmp" \
	DOTFILES_NVIM_REPOSITORY="file://$work/dotfiles.git" \
	DOTFILES_YADM_URL="file://$work/yadm" \
	DOTFILES_YADM_SHA256="$yadm_sha256" \
	bash "$root/.config/dotfiles/bin/portable" --worktree)"
printf '%s\n' "$worktree_output" | grep -F 'worktree-snapshot' >/dev/null

printf '%s\n' 'portable integration test passed'
