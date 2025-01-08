if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup completions
if test -d /opt/homebrew/share/fish/completions
    set -p fish_complete_path /opt/homebrew/share/fish/completions
end

if test -d "/opt/homebrew/share/fish/vendor_completions.d"
    set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
end

if test -d "$HOME/.config/fish/completions"
    set -p fish_complete_path $HOME/.config/fish/completions
end

# Disable welcome message
set -U fish_greeting

# Set other variables
set -gx EDITOR nvim
set -gx GIT_EDITOR $EDITOR
set -gx VISUAL $EDITOR
set -gx XDG_CONFIG_HOME $HOME/.config

# Set PATH
set --universal fish_user_paths $fish_user_paths /opt/homebrew/bin "/Applications/Postgres.app/Contents/Versions/latest/bin" "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$HOME/.config/scripts" "$HOME/.cargo/bin" $HOME/.krew/bin

abbr gs "git status"
abbr gd "git diff"
abbr ga 'git add'
abbr gcm 'git commit -m'
abbr gd 'git diff'
abbr gs 'git status'

# Initialize apps
eval "$(/opt/homebrew/bin/brew shellenv)"
zoxide init fish | source
fzf --fish | source
