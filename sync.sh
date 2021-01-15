#!/usr/bin/env bash

PATHS=()
TEMPS=()
ARCHIVES=()

PATHS+=("$HOME/.alfred/Alfred.alfredpreferences")
TEMPS+=("$HOME/.alfred/Alfred.alfredpreferences.tar.gz")
ARCHIVES+=("$HOME/Library/Mobile Documents/com~apple~CloudDocs/vietduc/alfred/Alfred.alfredpreferences.tar.gz")

for ((i = 0; i < "${#PATHS[@]}"; i++)); do
  path="${PATHS[i]}"
  temp="${TEMPS[i]}"
  archive="${ARCHIVES[i]}"
  tar czf "$temp" -C "$path" .
  mv "$temp" "$archive"
done
