#!/bin/zsh


source ~/.zshrc

name=$(basename "$PWD")

if [ $# -eq 0 ]; then
    selected=$(find $codingDirPath -type d -not -path '*/.*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/target/*' | fzf)
    [ -z "$selected" ] && exit 1
    name=$(basename "$selected")
    cd "$selected"
fi

if [ "$1" = "new" ]; then
    if [ -z "$2" ]; then
        echo "name required"
        exit 1
    fi
    mkdir "$codingDirPath/$2"
    cd "$codingDirPath/$2"
    name="$2"
fi

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
