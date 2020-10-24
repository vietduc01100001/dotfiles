export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"
DISABLE_UPDATE_PROMPT="true"
ZSH_DISABLE_COMPFIX="true"

plugins=(
  git
  docker
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-better-npm-completion
  zsh-safe-rm
  autoupdate
)

source $ZSH/oh-my-zsh.sh

# Init starship theme
eval "$(starship init zsh)"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Load gcloud
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# Dotfiles commands
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="config status"
alias cadd="config add"
alias crm="config reset HEAD -- "
alias cdc="config checkout -- "
function cdown() {
  config pull
  omz update
  source ~/.zshrc
}
function cup() {
  for file in $(config ls-files); do
    config add "$HOME/$file"
  done
  config commit -m "update @ $(date +"%c")"
  config push
}

# Other aliases & commands
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
