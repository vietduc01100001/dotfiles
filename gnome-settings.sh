#!/usr/bin/env bash

cmd=$1
path=$2

if [[ "$cmd" == "backup" ]]; then
    mkdir -p ~/.gnome/backup
    file="$HOME/.gnome/backup/gnome-settings-$(date +%s).dconf"
    dconf dump / > $file
    echo "Settings backed up: $file"
elif [[ "$cmd" == "load" ]]; then
    if [ -f "$path" ]; then
        dconf load / < $path
        echo "Settings loaded: $path"
    else
        echo "Path is not a file!"
    fi
else
    echo "Unrecognized command!"
fi
