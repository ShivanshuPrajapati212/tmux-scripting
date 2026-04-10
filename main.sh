#!/bin/bash

tmux new -s nvim -d
tmux send-keys -t nvim 'nvim' C-m
tmux attach -t nvim
