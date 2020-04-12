#!/usr/bin/env bash

cmd=$1
path=$2

if [[ "$cmd" == "backup" ]]; then
    filename="gnome-settings-$(date +%s).dconf"
    dconf dump / > "./$filename"
    echo "Settings backed up: $filename"
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
