#!/usr/bin/env bash

# This script is originally from https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

dirs=$(echo $WORKDIRS | tr ':' ' ')

if [[ $# -eq 1 ]]; then
    selected=$(find $dirs -mindepth 2 -maxdepth 1 -type d -name ecommerce)
else
    selected=$(find $dirs -mindepth 1 -maxdepth 1 -type d | fzf)
fi

echo $selected
if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
