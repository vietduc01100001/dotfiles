# -----------------------------------------------------------------------------
# Global options
# -----------------------------------------------------------------------------

# Path to your oh-my-zsh installation
export ZSH="/home/vietduc/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="minimal"

# Uncomment the following line to automatically update without prompting
DISABLE_UPDATE_PROMPT="true"

# Which plugins would you like to load?
plugins=(
    git
    docker
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-nvm
    zsh-better-npm-completion
    zsh-safe-rm
    autoupdate
)

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# User configuration
# -----------------------------------------------------------------------------

# Dotfiles commands
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="config status"
alias cadd="config add"
alias crm="config reset HEAD -- "
alias cdc="config checkout -- "
function cdown() {
    config pull
    upgrade_oh_my_zsh
    source ~/.zshrc
    gcloud components update -q
    # TODO: docker-compose, exa, bat
}
function cup() {
    for file in $(config ls-files); do
        config add "$HOME/$file"
    done
    config commit -m "update @ $(date --rfc-3339=s)"
    config push
}

# PATHs

# user bin
export PATH=$PATH:$HOME/.local/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# go
[[ -s "/home/vietduc/.gvm/scripts/gvm" ]] && source "/home/vietduc/.gvm/scripts/gvm"
alias cdgo="cd $GOPATH"

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

alias tm="tmuxp load -y"

# Personal functions

function mkcd() {
    mkdir -p -- "$1"
    cd -P -- "$1" || return
}

function docker_image_rm_all() {
    docker rmi -f "$(docker images -a -q)"
}

function git_branch_clean() {
    for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
        git branch -D "$branch"
    done
    git remote prune origin
}

# Load starship theme
eval "$(starship init zsh)"
