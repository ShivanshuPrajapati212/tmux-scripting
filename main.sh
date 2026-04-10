#!/bin/bash

name=$(basename "$PWD")


if tmux has-session -t $name 2>/dev/null; then
  tmux attach -t $name
  exit
fi

tmux new -s $name -d
tmux send-keys -t $name 'nvim .' C-m
tmux rename-window -t $name nvim

tmux new-window -t $name
tmux rename-window -t $name zsh 
tmux send-keys -t $name 'neofetch' C-m

tmux new-window -t $name
tmux rename-window -t $name git 
tmux send-keys -t $name 'git status' C-m

tmux new-window -t $name
tmux rename-window -t $name other 

tmux select-window -t $name:1
 
tmux attach -t $name 
