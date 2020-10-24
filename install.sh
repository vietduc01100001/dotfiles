#!/usr/bin/env bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install terminal programs
brew install wget fzf exa bat shellcheck starship

# Enable fzf
"$(brew --prefix)"/opt/fzf/install

# Install Oh My Zsh, themes & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zdharma/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/lukechilds/zsh-better-npm-completion "$ZSH_CUSTOM/plugins/zsh-better-npm-completion"
git clone --recursive --depth 1 https://github.com/mattmc3/zsh-safe-rm.git "$ZSH_CUSTOM/plugins/zsh-safe-rm"
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$ZSH_CUSTOM/plugins/autoupdate"

# Install nvm, Node & packages
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
nvm install --lts
npm i -g yarn typescript tldr

# Install gvm & Go
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4 --prefer-binary
