# dotfiles

Personal macOS-oriented dotfiles, managed with [yadm](https://yadm.io).

By Rémino Rem<br> <https://remino.net/>

[Code Repo](https://github.com/remino/dotfiles) | [ISC License](LICENSE.txt)

---

<!-- mtoc-start -->

- [What's Included](#whats-included)
- [Installation](#installation)
    - [Zsh Base Configuration](#zsh-base-configuration)
    - [Vim (lite)](#vim-lite)
- [Contributing](#contributing)
- [License](#license)

<!-- mtoc-end -->

---

## What's Included

Configuration is provided for:

- Shell: [Zsh](https://www.zsh.org/),
  [Powerlevel10k](https://github.com/romkatv/powerlevel10k),
  [Atuin](https://atuin.sh/), and [mise-en-scene](https://mise.jdx.dev/)
- Terminal: [Ghostty](https://ghostty.org/) and
  [tmux](https://github.com/tmux/tmux)
- Development tools: [Git](https://git-scm.com/),
  [GitHub CLI](https://cli.github.com/),
  [ripgrep](https://github.com/BurntSushi/ripgrep),
  [bat](https://github.com/sharkdp/bat), [Vim](https://www.vim.org/), and
  [EditorConfig](https://editorconfig.org/)
- Utilities: [Fastfetch](https://github.com/fastfetch-cli/fastfetch),
  [Finicky](https://github.com/johnste/finicky),
  [yt-dlp](https://github.com/yt-dlp/yt-dlp),
  [Tridactyl](https://github.com/tridactyl/tridactyl),
  [GnuPG](https://gnupg.org/), and OpenSSH

It also contains configuration for `cheat`, `curl`, `gh`, `shellcheck`, and a
few small helper scripts.

[Back to top](#)

---

## Installation

Install [yadm](https://yadm.io/) first, then clone the repository:

```sh
yadm clone https://github.com/remino/dotfiles
```

After cloning, review the files yadm manages:

```sh
yadm diff
```

The yadm bootstrap script installs the base Zsh loader when necessary and, when
`~/.config/nvim` does not already exist, clones
[`remino/nvim`](https://github.com/remino/nvim) there. The Neovim clone uses an
SSH Git URL, so ensure your GitHub SSH access is configured before running it.

To rerun the bootstrap step manually:

```sh
~/.config/yadm/bootstrap
```

### Zsh Base Configuration

The durable Zsh configuration lives in `~/.config/zsh/base`. The `~/.zshenv` and
`~/.zshrc` loader files may be recreated or modified by other tools without
changing that base configuration. To reinstall those loaders:

```sh
~/.config/yadm/install_zshrc
```

### Vim (lite)

The managed [`~/.vimrc`](../.vimrc) is a lightweight fallback for machines
that have Vim but not Neovim. It deliberately works without plugins or a
network connection: persistent undo, true colour (when supported), split and
completion defaults, file browsing, and project search are all built in.

`<Space>` is the leader key and `;` enters command-line mode. With
[ripgrep](https://github.com/BurntSushi/ripgrep) installed, these commands and
mappings provide project navigation through Vim's quickfix list:

| Mapping / command | Use |
| --- | --- |
| `<Space>ff` or `:Files` | List project files; opens the quickfix window. |
| `<Space>fg` or `:Grep {pattern}` | Search project files; opens quickfix. |
| `:cnext` / `:cprev` | Move through the current quickfix results. |
| `<Space>cq` | Close the quickfix window. |
| `<Space>e` | Open Vim's built-in file explorer. |
| `<Space>w` | Save. |

Plugins are optional. To enable the configured plugin set, install
[vim-plug](https://github.com/junegunn/vim-plug) once, then install the
declared plugins:

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
```

From Vim, use `:PlugStatus` to inspect plugins, `:PlugUpdate` to update them,
and `:PlugClean` to remove plugins no longer declared in `.vimrc`. The current
optional plugins add these conveniences:

| Plugin | How to use it |
| --- | --- |
| `editorconfig-vim` | Applies nearby `.editorconfig` files automatically. |
| `vim-commentary` | `gcc` comments the current line; `gc` followed by a motion comments it; select text and press `gc` for a visual selection. |
| `vim-fugitive` | `<Space>gg` opens `:Git`; also use `:Gdiffsplit`, `:Gwrite`, and `:Gread`. |
| `vim-surround` | Use `ys{motion}{surround}`, `cs{old}{new}`, and `ds{surround}`; e.g. `ysiw]` wraps a word in brackets. |
| `fzf.vim` | Use `:FZF`, `:Buffers`, `:History`, or `:Rg {pattern}` (requires the `fzf` executable; `:Rg` also requires ripgrep). |
| `dash.vim` | On macOS with Dash installed, use `:Dash` to look up the word under the cursor. |

The native `:Files` command intentionally remains available even after
installing `fzf.vim`; use `:FZF` when you want its interactive picker.

[Back to top](#)

---

## Contributing

This is primarily a personal configuration repository, but focused fixes and
improvements are welcome. Please open an issue or pull request with a concise
description of the change.

[Back to top](#)

---

## License

Distributed under the ISC License. See [LICENSE.txt](LICENSE.txt).

[Back to top](#)
