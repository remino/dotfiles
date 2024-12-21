# dotfiles

By Rémino Rem <https://remino.net>

Small collection of dotfiles.

- [About](#about)
- [Getting Started](#getting-started)
  - [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About

A minimal collection of dotfiles to work with:

- [asdf](https://asdf-vm.com)
- [bat](https://github.com/sharkdp/bat)
- [EditorConfig](https://editorconfig.org)
- [exa](https://the.exa.website)
- [getup](https://github.com/remino/getup)
- [Git](https://git-scm.com)
- [GitHub CLI](https://cli.github.com) (gh)
- [GnuPG](https://gnupg.org) (gpg)
- [Homebrew](https://brew.sh)
- [iTerm2](https://iterm2.com)
- [Karabiner Elements](https://karabiner-elements.pqrs.org)
- [npm](https://docs.npmjs.com)
- [Oh My Zsh](https://ohmyz.sh)
- [OpenSSH](https://www.openssh.com) (ssh)
- [pnpm](https://pnpm.io)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [tmux](https://tmux.github.io/)
- [trash](https://hasseg.org/trash/)
- [Vim](https://www.vim.org/)
- [yadm](https://yadm.io)
- [youtube-dl](https://youtube-dl.org)
- [Z Shell](https://zsh.sourceforge.io) (zsh)

## Getting Started

The dotfiles should work on their own if you move, copy, or symlink every file
where they belong, but using a dotfile manager like [yadm](https://yadm.io) is
recommended.

### Installation

```sh
# On its own
cd ~
git clone https://github.com/remino/dotfiles .config/dotfiles
# Copy files you need
cp ~/.config/dotfiles/.zshrc ~/.zshrc
# Or create symlinks to them
ln -s .config/dotfiles/.zshrc
# Run bootstrap script
~/.config/yadm/bootstrap

# By using yadm
yadm clone https://github.com/remino/dotfiles
# The above will automatically move in all dotfiles in your home directory.
# Review the changes
yadm diff
```

### `.zshrc` Base

To keep the `.zshrc` file clean, the base config has been moved to
`.config/zsh/base/zshrc`.

Thanks to this, you can have scripts mess with the `.zshrc` file without having
to worry about breaking the base config.

If it's sourced already, you can run the `install_zshrc` script to install it:

```sh
~/.config/yadm/install_zshrc
```

[Back to top](#dotfiles)

## Contributing

Contributions are what make the open source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly
appreciated**.

If you have a suggestion that would make this better, please fork the repo and
create a pull request. You can also simply open an issue with the tag
"enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

[Back to top](#dotfiles)

## License

Distributed under the ISC License. See `LICENSE.txt` for more information.

[Back to top](#dotfiles)

## Contact

Rémino Rem https://remino.net/

[Back to top](#dotfiles)
