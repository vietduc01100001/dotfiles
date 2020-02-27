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
  docker
  docker-compose
  fzf
  git
  git-auto-fetch
  golang
  kubectl
  minikube
  npm
  nvm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# The next line updates PATH for the Google Cloud SDK
if [ -f '/home/vietduc/google-cloud-sdk/path.zsh.inc' ]; then . '/home/vietduc/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud
if [ -f '/home/vietduc/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/vietduc/google-cloud-sdk/completion.zsh.inc'; fi

source $ZSH/oh-my-zsh.sh

# The next lines set up Go environment variables
export GOPATH=$HOME/dev/go
export GOBIN=$GOPATH/bin

PATH=$PATH:$GOPATH:$GOBIN
export PATH

# -----------------------------------------------------------------------------
# User configuration
# -----------------------------------------------------------------------------

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes.

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ..="cd .."
alias ...="cd ../.."

alias grep="grep --color"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias gs="git status"
alias gl="git log --oneline -n 20"

# Personal functions

function mkcd(){ mkdir -p -- "$1" && cd -P -- "$1"; }

function config_update() {
  config pull
  source ~/.zshrc
}
