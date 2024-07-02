if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Make su launch fish
function su
    command su --shell=/usr/bin/fish $argv
end

# Setup completions
if test -d /opt/homebrew/share/fish/completions
    set -p fish_complete_path /opt/homebrew/share/fish/completions
end

if test -d "/opt/homebrew/share/fish/vendor_completions.d"
    set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
end

# Disable welcome message
set -U fish_greeting

# Set other variables
set -gx EDITOR nvim
set -gx GIT_EDITOR $EDITOR
set -gx VISUAL $EDITOR
set -gx XDG_CONFIG_HOME $HOME/.config
# set -U SHELL /usr/local/bin/fish

# Set PATH
set --universal fish_user_paths $fish_user_paths /opt/homebrew/bin "/Applications/Postgres.app/Contents/Versions/latest/bin" "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$HOME/.config/scripts" "$HOME/.cargo/bin" $HOME/.krew/bin

# Initialize other apps
eval "$(/opt/homebrew/bin/brew shellenv)"
zoxide init fish | source
fzf --fish | source
starship init fish | source
