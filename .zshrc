#############
# Oh My ZSH #
#############

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

#####################
# Dotfiles commands #
#####################

alias config='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
alias cs="config status"
alias cadd="config add"
alias cdc="config checkout -- "
alias cus="config reset --"
function cdown() {
  config pull
  omz update
  asdf plugin update --all
  source ~/.zshrc
}
function cup() {
  for file in $(config ls-files); do
    config add "$HOME/$file"
  done
  config commit -m "update @ $(date +"%c")"
  config push
}
function ch() {
  echo -e "config: Manage dotfiles\n"
  echo -e "cs\tCheck the status of the dotfiles repo"
  echo -e "cadd\tTrack new dotfiles"
  echo -e "cdc\tDiscard changes to a file"
  echo -e "cus\tUnstage a file"
  echo -e "cdown\tPull changes from remote and apply them"
  echo -e "cup\tCommit all local changes to remote"
  echo -e "ch\tShow help"
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
alias grc="git rebase --continue"
alias prc="gh pr create -w"

alias dcls="docker container ls"

function mkcd() {
  mkdir -p -- "$1"
  cd -P -- "$1" || return
}

function docker_image_rm_all() {
  docker rmi -f "$(docker images -a -q)"
}

function git_branch_clean() {
  git remote prune origin
  for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
    git branch -D "$branch"
  done
}

###########
# Loaders #
###########

# Init starship theme
eval "$(starship init zsh)"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf
. $(brew --prefix asdf)/asdf.sh

# Load github cli
eval "$(gh completion -s zsh)"

########################
# Load private scripts #
########################

# Not-so-private first
alias avengers="itomate -c $HOME/avengers.yml"

# Really private later
[ -f ~/.private.sh ] && source ~/.private.sh
