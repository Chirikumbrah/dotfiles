#!/bin/sh

PANES=$(tmux list-panes | wc -l)
if [ "$PANES" -gt 1 ]
  then
    tmux send-keys -t 2 "clear" Enter
  else
    tmux split-window -v -p 30
fi
