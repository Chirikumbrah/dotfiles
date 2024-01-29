function tn --wraps='tmux new-session -s default' --description 'alias tn=tmux new-session -s default'
    tmux new-session -s default $argv
end
