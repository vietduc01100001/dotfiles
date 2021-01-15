#!/usr/bin/env bash

# Prerequisites:
# - Xcode command-line tools
# - SSH keys to GitHub

REMOTE="git@github.com:hellovietduc/dotfiles.git"
if [ -n "$1" ]; then
  REMOTE="$1"
fi

# Remove existed .git directory if any
rm -rf "$HOME"/.git

# Init tracking dotfiles in home directory
git init --bare "$HOME"/.git
alias config='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config remote add origin "$REMOTE"
config pull origin master
config branch --set-upstream-to=origin/master master

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install brew packages
brew bundle

# Enable fzf
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion

# Install Oh My Zsh, themes & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zdharma/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/lukechilds/zsh-better-npm-completion "$ZSH_CUSTOM/plugins/zsh-better-npm-completion"
git clone --recursive --depth 1 https://github.com/mattmc3/zsh-safe-rm.git "$ZSH_CUSTOM/plugins/zsh-safe-rm"
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$ZSH_CUSTOM/plugins/autoupdate"

# Add asdf plugins
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  asdf plugin add "$name"
  echo "Added plugin: $name"
done <"$HOME/.tool-versions"

# Install all packages listed in ~/.tool-versions
NODEJS_CHECK_SIGNATURES=no asdf install

# Set versions globally
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  version="$(echo $line | cut -d " " -f2)"
  asdf global "$name" "$version"
  echo "Set package globally: $name $version"
done <"$HOME/.tool-versions"

# Install itomate
# Require Enable Python API in iTerm 2
pip install itomate

# Reshim packages, should always be the last
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  asdf reshim "$name"
  echo "Reshimmed: $name $version"
done <"$HOME/.tool-versions"

# Load crontab
echo "0 * * * * $HOME/sync.sh" >"$HOME/cron"
crontab cron
