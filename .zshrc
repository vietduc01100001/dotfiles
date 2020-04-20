# -----------------------------------------------------------------------------
# Global options
# -----------------------------------------------------------------------------

# Path to your oh-my-zsh installation
export ZSH="/home/vietduc/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion
# Case-sensitive completion must be off. _ and - will be interchangeable
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion
# COMPLETION_WAITING_DOTS="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
plugins=(
    git
    git-auto-fetch
    docker
    docker-compose
    kubectl
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-nvm
    zsh-better-npm-completion
    zsh-safe-rm
    autoupdate
)

# config k8s section in spaceship theme
export SPACESHIP_KUBECTL_SHOW=true
export SPACESHIP_KUBECTL_VERSION_SHOW=false

# Set this before sourcing Oh My Zsh and plugins
export NVM_LAZY_LOAD=true

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# User configuration
# -----------------------------------------------------------------------------

# Dotfiles commands
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="config status"
alias cadd="config add"
alias crm="config reset HEAD -- "
function cdown() {
    config pull
    upgrade_oh_my_zsh
    source ~/.zshrc
    gcloud components update -q
    # TODO: docker-compose, exa, bat
}
function cup() {
    for file in `config ls-files`; do
        config add "$HOME/$file"
    done
    config commit -m "update @ $(date --rfc-3339=s)"
    config push
}

# PATHs

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# go
export GOPATH=$HOME/dev/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOPATH:$GOBIN
export PATH

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes.

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ..="cd .."
alias ...="cd ../.."
alias ls="exa"

alias cat="bat --pager=nerver --style=plain"
alias grep="grep --color"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias gs="git status"
alias gl="git log --oneline -n 20"

# Personal functions

function mkcd() { mkdir -p -- "$1" && cd -P -- "$1"; }

function docker_rm_all_images() { docker rmi -f $(docker images -a -q) }
