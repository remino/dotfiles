# dotfiles

Personal macOS-oriented dotfiles, managed with [yadm](https://yadm.io).

By Rémino Rem<br>
<https://remino.net/>

[Code Repo](https://github.com/remino/dotfiles)
| [ISC License](LICENSE.txt)

---

<!-- mtoc-start -->

- [What's Included](#whats-included)
- [Installation](#installation)
    - [Zsh Base Configuration](#zsh-base-configuration)
- [Contributing](#contributing)
- [License](#license)

<!-- mtoc-end -->

---

## What's Included

Configuration is provided for:

- Shell: [Zsh](https://www.zsh.org/), [Powerlevel10k](https://github.com/romkatv/powerlevel10k), [Atuin](https://atuin.sh/), and [mise-en-scene](https://mise.jdx.dev/)
- Terminal: [Ghostty](https://ghostty.org/) and [tmux](https://github.com/tmux/tmux)
- Development tools: [Git](https://git-scm.com/), [GitHub CLI](https://cli.github.com/), [ripgrep](https://github.com/BurntSushi/ripgrep), [bat](https://github.com/sharkdp/bat), and [EditorConfig](https://editorconfig.org/)
- Utilities: [Fastfetch](https://github.com/fastfetch-cli/fastfetch), [Finicky](https://github.com/johnste/finicky), [yt-dlp](https://github.com/yt-dlp/yt-dlp), [Tridactyl](https://github.com/tridactyl/tridactyl), [GnuPG](https://gnupg.org/), and OpenSSH

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

The yadm bootstrap script installs the base Zsh loader when necessary and,
when `~/.config/nvim` does not already exist, clones
[`remino/nvim`](https://github.com/remino/nvim) there. The Neovim clone uses an
SSH Git URL, so ensure your GitHub SSH access is configured before running it.

To rerun the bootstrap step manually:

```sh
~/.config/yadm/bootstrap
```

### Zsh Base Configuration

The durable Zsh configuration lives in `~/.config/zsh/base`. The
`~/.zshenv` and `~/.zshrc` loader files may be recreated or modified by other
tools without changing that base configuration. To reinstall those loaders:

```sh
~/.config/yadm/install_zshrc
```

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
