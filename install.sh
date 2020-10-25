#!/usr/bin/env bash

# Prerequisites
# - Xcode command-line tools
# - SSH keys to GitHub

# Init tracking dotfiles in home directory
git init --bare "$HOME"/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config remote add origin git@github.com:hellovietduc/dotfiles.git
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

# Install Node & packages
nodenv install 12.19.0
nodenv global 12.19.0
npm i -g yarn typescript

# Install gvm & Go
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4 --prefer-binary
