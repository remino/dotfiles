# ########  ######  ##     ## ########   ######
#      ##  ##    ## ##     ## ##     ## ##    ##
#     ##   ##       ##     ## ##     ## ##
#    ##     ######  ######### ########  ##
#   ##           ## ##     ## ##   ##   ##
#  ##      ##    ## ##     ## ##    ##  ##    ##
# ########  ######  ##     ## ##     ##  ######

################################################################################

# ##     ##  #######  ##     ## ######## ########  ########  ######## ##      ##
# ##     ## ##     ## ###   ### ##       ##     ## ##     ## ##       ##  ##  ##
# ##     ## ##     ## #### #### ##       ##     ## ##     ## ##       ##  ##  ##
# ######### ##     ## ## ### ## ######   ########  ########  ######   ##  ##  ##
# ##     ## ##     ## ##     ## ##       ##     ## ##   ##   ##       ##  ##  ##
# ##     ## ##     ## ##     ## ##       ##     ## ##    ##  ##       ##  ##  ##
# ##     ##  #######  ##     ## ######## ########  ##     ## ########  ###  ###

# For M1 Macs, init Homebrew first:
[ -x "/opt/homebrew/bin/brew" ] && eval "$( /opt/homebrew/bin/brew shellenv )"

#  ######  ########  ########     ###    ######## ##     ##
# ##    ## ##     ## ##     ##   ## ##      ##    ##     ##
# ##       ##     ## ##     ##  ##   ##     ##    ##     ##
# ##       ##     ## ########  ##     ##    ##    #########
# ##       ##     ## ##        #########    ##    ##     ##
# ##    ## ##     ## ##        ##     ##    ##    ##     ##
#  ######  ########  ##        ##     ##    ##    ##     ##

cat <<DIRS | while read -r dir
	$HOME
	$HOME/Library/Mobile Documents/com~apple~CloudDocs
DIRS
do
	[ ! -d "$dir" ] && continue
	cdpath+=($dir)
done

# ######## ##     ## ####  ######  ########  ######
# ##        ##   ##   ##  ##    ##    ##    ##    ##
# ##         ## ##    ##  ##          ##    ##
# ######      ###     ##   ######     ##     ######
# ##         ## ##    ##        ##    ##          ##
# ##        ##   ##   ##  ##    ##    ##    ##    ##
# ######## ##     ## ####  ######     ##     ######

_exists() {
	command -v "$1" >/dev/null 2>&1
}

_which_exists() {
	for cmd in "$@"
	do
		! ( _exists "$cmd" ) && continue
		echo "$cmd"
		return
	done
}

# ########     ##     #####   ##    ##
# ##     ##  ####    ##   ##  ##   ##
# ##     ##    ##   ##     ## ##  ##
# ########     ##   ##     ## #####
# ##           ##   ##     ## ##  ##
# ##           ##    ##   ##  ##   ##
# ##         ######   #####   ##    ##

ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ########     ###    ######## ##     ##
# ##     ##   ## ##      ##    ##     ##
# ##     ##  ##   ##     ##    ##     ##
# ########  ##     ##    ##    #########
# ##        #########    ##    ##     ##
# ##        ##     ##    ##    ##     ##
# ##        ##     ##    ##    ##     ##

path+=(
	"$HOME/bin"
)

#  ######   ######  ##     ##            ###     ######   ######## ##    ## ########
# ##    ## ##    ## ##     ##           ## ##   ##    ##  ##       ###   ##    ##
# ##       ##       ##     ##          ##   ##  ##        ##       ####  ##    ##
#  ######   ######  ######### ####### ##     ## ##   #### ######   ## ## ##    ##
#       ##       ## ##     ##         ######### ##    ##  ##       ##  ####    ##
# ##    ## ##    ## ##     ##         ##     ## ##    ##  ##       ##   ###    ##
#  ######   ######  ##     ##         ##     ##  ######   ######## ##    ##    ##

share_ssh_agent() {
	[ -z "$SSH_AUTH_SOCK" ] && return
	ssh_agent_path="$HOME/.ssh/agent"
	printenv | grep '^SSH' | sed -E 's/^([^=]+)=(.*)$/\1="\2"; export \1;/' > "$ssh_agent_path"
}

share_ssh_agent

zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes

plugins+=(
	ssh-agent
)

#    ###    ##       ####    ###     ######  ########  ######
#   ## ##   ##        ##    ## ##   ##    ## ##       ##    ##
#  ##   ##  ##        ##   ##   ##  ##       ##       ##
# ##     ## ##        ##  ##     ##  ######  ######    ######
# ######### ##        ##  #########       ## ##             ##
# ##     ## ##        ##  ##     ## ##    ## ##       ##    ##
# ##     ## ######## #### ##     ##  ######  ########  ######

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias e='edit'
alias edit='eval $EDITOR'
alias reload=". \$HOME/.zshrc"
alias tree='tree -CN'
alias v=vim
alias zshrc='eval $EDITOR "$HOME/.zshrc"'

# ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
# ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
# ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
# ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
# ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
# ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
# ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######

mvhere() {
	mv -v "$@" .
}

mvln() {
	mv -v "$@" && ln -sv "$@"
}

# ########  ##       ##     ##  ######   #### ##    ##  ######
# ##     ## ##       ##     ## ##    ##   ##  ###   ## ##    ##
# ##     ## ##       ##     ## ##         ##  ####  ## ##
# ########  ##       ##     ## ##   ####  ##  ## ## ##  ######
# ##        ##       ##     ## ##    ##   ##  ##  ####       ##
# ##        ##       ##     ## ##    ##   ##  ##   ### ##    ##
# ##        ########  #######   ######   #### ##    ##  ######

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins+=(
	autoupdate

	alias-finder
	aliases
	catimg
	dirhistory
	fancy-ctrl-z
	macos
	vi-mode
	youtube-dl
	zsh-interactive-cd
)

cat <<LIST | while read -r cmd add
rsync cp
date isodate
fd
gh
git git git-aliases
git-extras
gpg-agent
mysql mysql-alias
op 1password
sudo
system

fzf
LIST
do
	[ -z "$cmd" ] && continue
	[ -z "$add" ] && add="$cmd"
	_exists $cmd || continue

	echo "$add" | tr ' ' '\n' | while read -r plugin
	do
		plugins+=($plugin)
	done
done

#    ###     ######  ########  ########
#   ## ##   ##    ## ##     ## ##
#  ##   ##  ##       ##     ## ##
# ##     ##  ######  ##     ## ######
# #########       ## ##     ## ##
# ##     ## ##    ## ##     ## ##
# ##     ##  ######  ########  ##

if _exists asdf
then
	ASDF_CONFIG_FILE="$HOME/.config/asdf/config"
	plugins+=(asdf)
fi

# ########     ###    ########
# ##     ##   ## ##      ##
# ##     ##  ##   ##     ##
# ########  ##     ##    ##
# ##     ## #########    ##
# ##     ## ##     ##    ##
# ########  ##     ##    ##

export BATCMD="$( _which_exists batcat bat )"

if [ -n "$BATCMD" ]
then
	[ "$BATCMD" != "bat" ] && alias bat="\$BATCMD"
	alias cat=bat
	export MANPAGER="sh -c 'col -bx | \$BATCMD -l man -p'"
fi

# ########  ########  ######## ##      ##
# ##     ## ##     ## ##       ##  ##  ##
# ##     ## ##     ## ##       ##  ##  ##
# ########  ########  ######   ##  ##  ##
# ##     ## ##   ##   ##       ##  ##  ##
# ##     ## ##    ##  ##       ##  ##  ##
# ########  ##     ## ########  ###  ###

if _exists brew
then
	alias bi='brew install'
	alias bn='brew info'
	alias bs='brew search'
fi

plugins+=(
	brew
)

# ######## ########  #### ########  #######  ########
# ##       ##     ##  ##     ##    ##     ## ##     ##
# ##       ##     ##  ##     ##    ##     ## ##     ##
# ######   ##     ##  ##     ##    ##     ## ########
# ##       ##     ##  ##     ##    ##     ## ##   ##
# ##       ##     ##  ##     ##    ##     ## ##    ##
# ######## ########  ####    ##     #######  ##     ##

editor() {
	[ $# -lt 1 ] && echo "$EDITOR" && return

	case "$1" in
		code|vscode) export EDITOR='code -w' ;;
		*) export EDITOR='vim' ;;
	esac

	echo "$EDITOR"
}

# Preferred editor for local and remote sessions
if [ -z "$SSH_CONNECTION" ] && _exists code
then
  editor code > /dev/null
else
  editor vim > /dev/null
fi

# ########    ###     ######  ######## ######## #### ##       ########
# ##         ## ##   ##    ##    ##    ##        ##  ##       ##
# ##        ##   ##  ##          ##    ##        ##  ##       ##
# ######   ##     ##  ######     ##    ######    ##  ##       ######
# ##       #########       ##    ##    ##        ##  ##       ##
# ##       ##     ## ##    ##    ##    ##        ##  ##       ##
# ##       ##     ##  ######     ##    ##       #### ######## ########

fastfile_var_prefix='^'
fastfile_dir="$HOME/.config/fastfile/"

plugins+=(
	fastfile
)

#  ######   ######## ######## ##     ## ########
# ##    ##  ##          ##    ##     ## ##     ##
# ##        ##          ##    ##     ## ##     ##
# ##   #### ######      ##    ##     ## ########
# ##    ##  ##          ##    ##     ## ##
# ##    ##  ##          ##    ##     ## ##
#  ######   ########    ##     #######  ##

getup() {
	getup_path="$( whereis -b getup | awk '{print $2}' )"

	if [ -n "$getup_path" ]
	then
		"$getup_path" "$@"
		return
	fi

	getup_path="$HOME/bin/getup"

	if [ ! -a "$getup_path" ]
	then
		echo "Downloading getup..."
		curl -sL https://github.com/remino/getup/raw/main/getup > "$getup_path"
		chmod +x "$getup_path"
		echo "$getup_path"
		fi

	if [ -x "$getup_path" ]
	then
		"$getup_path" "$@"
		return
	fi

	echo "getup not found" >&2
}

# #### ######## ######## ########  ##     ##
#  ##     ##    ##       ##     ## ###   ###
#  ##     ##    ##       ##     ## #### ####
#  ##     ##    ######   ########  ## ### ##
#  ##     ##    ##       ##   ##   ##     ##
#  ##     ##    ##       ##    ##  ##     ##
# ####    ##    ######## ##     ## ##     ##

plugins+=(
	iterm2
)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ##    ## ########  ##     ##
# ###   ## ##     ## ###   ###
# ####  ## ##     ## #### ####
# ## ## ## ########  ## ### ##
# ##  #### ##        ##     ##
# ##   ### ##        ##     ##
# ##    ## ##        ##     ##

if _exists npm
then
	alias npma='npm add'
	alias npmb='npm run build'
	alias npmd='npm run dev'
	alias npmdo='npm run docs'
	alias npmi='npm install'
	alias npml='npm ls'
	alias npmr='npm run'
fi

plugins+=(
	npm
)

# ########   #######   #######  ########
# ##     ## ##     ## ##     ##    ##
# ##     ## ##     ## ##     ##    ##
# ########  ##     ## ##     ##    ##
# ##   ##   ##     ## ##     ##    ##
# ##    ##  ##     ## ##     ##    ##
# ##     ##  #######   #######     ##

if [ "$USER" = "root" ]
then
	cdpath+=(
		"/etc"
		"/opt"
		"/opt/$HOST"
		"/var/log"
		"/var/www"
	)
fi

# ######## ##     ## ##     ## ##     ##
#    ##    ###   ### ##     ##  ##   ##
#    ##    #### #### ##     ##   ## ##
#    ##    ## ### ## ##     ##    ###
#    ##    ##     ## ##     ##   ## ##
#    ##    ##     ## ##     ##  ##   ##
#    ##    ##     ##  #######  ##     ##

ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_CONFIG="$HOME/.config/tmux/tmux.conf"
ZSH_TMUX_UNICODE=true
ZSH_TMUX_DEFAULT_SESSION_NAME="$( hostname )"

if [ "$USER" = "root" ]
then
	ZSH_TMUX_AUTOSTART=false
else
	ZSH_TMUX_AUTOSTART=true
fi

if [ "$TERM_PROGRAM" = "iTerm.app" ]
then
	ZSH_TMUX_ITERM2=true
else
	ZSH_TMUX_ITERM2=false
fi

if _exists tmux
then
	alias tmuxlc='tmux source "$ZSH_TMUX_CONFIG"'
fi

plugins+=(
	tmux
)

# ######## ########     ###     ######  ##     ##
#    ##    ##     ##   ## ##   ##    ## ##     ##
#    ##    ##     ##  ##   ##  ##       ##     ##
#    ##    ########  ##     ##  ######  #########
#    ##    ##   ##   #########       ## ##     ##
#    ##    ##    ##  ##     ## ##    ## ##     ##
#    ##    ##     ## ##     ##  ######  ##     ##

if _exists trash
then
	alias rm='trash -F'
fi

# ##    ##    ###    ########  ##     ##
#  ##  ##    ## ##   ##     ## ###   ###
#   ####    ##   ##  ##     ## #### ####
#    ##    ##     ## ##     ## ## ### ##
#    ##    ######### ##     ## ##     ##
#    ##    ##     ## ##     ## ##     ##
#    ##    ##     ## ########  ##     ##

if _exists yadm
then
	cat <<ALIASES | while read -r alias cmd

a
c
co
lo
pl
po
st
ALIASES
	do
		[ -z "$cmd" ] && cmd="$alias"
		alias y$alias="yadm $cmd"
	done
fi

# ########  ##    ## ########  ##     ##
# ##     ## ###   ## ##     ## ###   ###
# ##     ## ####  ## ##     ## #### ####
# ########  ## ## ## ########  ## ### ##
# ##        ##  #### ##        ##     ##
# ##        ##   ### ##        ##     ##
# ##        ##    ## ##        ##     ##

[ -z "$PNPM_HOME" ] && PNPM_HOME="$HOME/Library/pnpm"

if [ -d "$PNPM_HOME" ]
then
	export PNPM_HOME
	export PATH="$PNPM_HOME:$PATH"
	[ -d "$ZSH_CUSTOM/plugins/pnpm" ] && plugins+=(pnpm)
fi

# ##        #######   ######     ###    ##
# ##       ##     ## ##    ##   ## ##   ##
# ##       ##     ## ##        ##   ##  ##
# ##       ##     ## ##       ##     ## ##
# ##       ##     ## ##       ######### ##
# ##       ##     ## ##    ## ##     ## ##
# ########  #######   ######  ##     ## ########

for include in "$HOME/.zshrc.local" "$HOME/.config/zsh/local"
do
	[ ! -f "$include" ] && continue
	source "$include"
done

# ##     ## ########  ######   ######     ###     ######   ########
# ###   ### ##       ##    ## ##    ##   ## ##   ##    ##  ##
# #### #### ##       ##       ##        ##   ##  ##        ##
# ## ### ## ######    ######   ######  ##     ## ##   #### ######
# ##     ## ##             ##       ## ######### ##    ##  ##
# ##     ## ##       ##    ## ##    ## ##     ## ##    ##  ##
# ##     ## ########  ######   ######  ##     ##  ######   ########

(
	hostname | ( _exists figlet && figlet || cat )
	_exists fortune && fortune -s
) | ( _exists lolcat && lolcat || command cat )

#  #######  ##     ##         ##     ## ##    ##         ########  ######  ##     ##
# ##     ## ##     ##         ###   ###  ##  ##               ##  ##    ## ##     ##
# ##     ## ##     ##         #### ####   ####               ##   ##       ##     ##
# ##     ## ######### ####### ## ### ##    ##    #######    ##     ######  #########
# ##     ## ##     ##         ##     ##    ##              ##           ## ##     ##
# ##     ## ##     ##         ##     ##    ##             ##      ##    ## ##     ##
#  #######  ##     ##         ##     ##    ##            ########  ######  ##     ##

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Path to your oh-my-zsh installation.
for omzpath in "$HOME/.oh-my-zsh" "/opt/oh-my-zsh"
do
	[ ! -d "$omzpath" ] && continue
	export ZSH="$omzpath"
	source "$ZSH/oh-my-zsh.sh"
	break
done

# ######## ##     ##    ###
# ##        ##   ##    ## ##
# ##         ## ##    ##   ##
# ######      ###    ##     ##
# ##         ## ##   #########
# ##        ##   ##  ##     ##
# ######## ##     ## ##     ##

if _exists exa
then
	alias exa='exa --git --group-directories-first'
	alias l='exa -la'
	alias ls=exa
	alias ll='exa -l'
fi
