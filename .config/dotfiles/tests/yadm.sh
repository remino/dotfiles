#!/bin/sh

# Exercise the normal yadm clone, alternate, template, and bootstrap flow in a
# disposable home. The source checkout is copied into a temporary local remote
# so the test also includes uncommitted changes to tracked dotfiles.
set -eu

root="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)"
work="$(mktemp -d "${TMPDIR:-/tmp}/remino-yadm-test.XXXXXX")"

cleanup() {
	rm -rf "$work"
}
trap cleanup EXIT HUP INT TERM

git clone --no-hardlinks "$root" "$work/checkout" >/dev/null
if ! git -C "$root" diff --quiet HEAD
then
	git -C "$root" diff --binary HEAD | git -C "$work/checkout" apply
	git -C "$work/checkout" -c user.name='yadm Docker test' -c user.email='test@example.invalid' commit -am 'Test working tree' >/dev/null
fi
git clone --bare "$work/checkout" "$work/dotfiles.git" >/dev/null

home="$work/home"

export HOME="$home"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Required template fragments are created by the same script the yadm installer
# invokes before its initial checkout.
"$root/.config/dotfiles/bin/create-local-files"

# --bootstrap supplies the affirmative answer yadm normally requests after a
# clone. Bootstrap must not require a network connection or SSH credentials.
yadm clone --bootstrap "file://$work/dotfiles.git"

test -f "$HOME/.config/zsh/base/zshenv"
test -f "$HOME/.config/zsh/base/zshrc"
test -f "$HOME/.config/yt-dlp/config"
test -f "$HOME/.gnupg/gpg.conf"
test ! -e "$HOME/.ssh/config.d/050-mac.conf"
grep -F 'source "$ZSHBASE"' "$HOME/.zshenv" >/dev/null
grep -F 'source "$ZSHBASE"' "$HOME/.zshrc" >/dev/null
test -z "$(yadm status --porcelain)"

TERM=dumb zsh -lic 'alias anchor >/dev/null'

printf '%s\n' 'yadm Docker integration test passed'
