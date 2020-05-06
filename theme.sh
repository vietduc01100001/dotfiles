#!/usr/bin/env bash

set -e pipefail

# Setting up some vars
CACHE_DIR="$HOME/.cache/ubuntu-setup"
THEME=$1

# Install multiple packages
apt_install() {
    if [ "${1}" == "-q" ]; then
        params=($@)
        for pkg in "${params[@]:1}"; do
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "${pkg}" > /dev/null || true
        done
    else
        for pkg in "$@"; do
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkg}" || true
        done
    fi
    sudo dpkg --configure -a || true
    sudo apt-get autoclean && sudo apt-get clean
}

download_themes_package() {
    variant=$1
    curl -sL "https://github.com/vietduc01100001/dotfiles/releases/download/1.2.1/mac-os-$variant-1.2.1.tar.xz" -o "$CACHE_DIR/mac-os-$variant.tar.xz"
    tar xf "$CACHE_DIR/mac-os-$variant.tar.xz" -C $CACHE_DIR
}

install_fonts() {
    variant=$1
    font_dir="$CACHE_DIR/mac-os-$variant/fonts"
    dir_roboto_mono="/usr/share/fonts/truetype/RobotoMono"
    dir_sf_pro="/usr/share/fonts/opentype/SFPro"

    # Create font directories
    [ ! -d "$dir_roboto_mono" ] && sudo mkdir -p $dir_roboto_mono
    [ ! -d "$dir_sf_pro" ] && sudo mkdir -p $dir_sf_pro

    # Copy fonts and rebuild font caches
    sudo cp $font_dir/RobotoMono/* $dir_roboto_mono/
    sudo cp $font_dir/SFPro/* $dir_sf_pro/
    sudo fc-cache -fv
}

install_themes() {
    variant=$1
    themes_dir="$CACHE_DIR/mac-os-$variant/themes"

    # Clean up themes directory
    [ ! -d "$HOME/.themes" ] && mkdir "$HOME/.themes"
    [ -d "$HOME/.themes/Mojave-$variant" ] && rm -rf "$HOME/.themes/Mojave-$variant"

    # Extract themes
    tar xf "$themes_dir/Mojave-$variant.tar.xz" -C ~/.themes
    cp "$themes_dir/catalina-$variant.jpg" "$themes_dir/catalina-$variant-blur.png" ~/.themes/
}

install_icons() {
    variant=$1
    icons_dir="$CACHE_DIR/mac-os-$variant/icons"

    # Clean up icons directory
    [ ! -d "$HOME/.icons" ] && mkdir "$HOME/.icons"
    [ -d "$HOME/.icons/Mojave-CT-$variant" ] && rm -rf "$HOME/.icons/Mojave-CT-$variant"
    [ -d "$HOME/.icons/OSX-ElCap" ] && rm -rf "$HOME/.icons/OSX-ElCap"

    # Extract icons
    tar xf "$icons_dir/Mojave-CT-$variant.tar.xz" -C ~/.icons
    tar xf "$icons_dir/OSX-ElCap.tar.xz" -C ~/.icons
    cp "$icons_dir/code.svg" "$HOME/.icons/Mojave-CT-$variant/apps/128/"
}

install_shell_extensions() {
    extensions_dir="$CACHE_DIR/shell-extensions"
    for filename in $extensions_dir/*; do
        uuid=$(unzip -c $filename metadata.json | grep uuid | cut -d \" -f4)
        dir_ext="$HOME/.local/share/gnome-shell/extensions/$uuid"
        mkdir -p $dir_ext
        unzip -o $filename -d $dir_ext > /dev/null
        gnome-shell-extension-tool -e $uuid
    done
}

change_gnome_settings() {
    variant=$1

    # Change font
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'SF Pro Display 11' > /dev/null || true
    gsettings set org.gnome.desktop.interface font-name 'SF Pro Display 10' > /dev/null || true
    gsettings set org.gnome.desktop.interface document-font-name 'SF Pro Display 10' > /dev/null || true
    gsettings set org.gnome.desktop.interface monospace-font-name 'Roboto Mono 11' > /dev/null || true

    # Change theme
    gsettings set org.gnome.desktop.interface gtk-theme "Mojave-$variant" > /dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme "Mojave-CT-$variant" > /dev/null || true
    gsettings set org.gnome.desktop.interface cursor-theme 'OSX-ElCap' > /dev/null || true
    gsettings set org.gnome.shell.extensions.user-theme name "Mojave-$variant" > /dev/null || true
    gsettings set org.gnome.terminal.legacy theme-variant "$variant" > /dev/null || true

    # Change wallpaper
    gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.themes/catalina-$variant.jpg" > /dev/null || true
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$HOME/.themes/catalina-$variant-blur.png" > /dev/null || true
}

# main
if [[ "$THEME" == "--dark" ]]; then
    apt_install gnome-tweak-tool gnome-shell-extensions
    download_themes_package dark
    install_fonts dark
    install_themes dark
    install_icons dark
    install_shell_extensions
    change_gnome_settings dark
    echo "MacOS Dark Theme is installed!"
elif [[ "$THEME" == "--light" ]]; then
    echo "Unsupported theme!"
else
    echo "Unsupported theme!"
fi
