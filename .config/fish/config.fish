if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Make su launch fish
function su
    command su --shell=/usr/bin/fish $argv
end

# Setup completions
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# Disable welcome message
set -U fish_greeting

# Set other variables
set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL $LANG
set -gx EDITOR hx
set -gx GIT_EDITOR $EDITOR
set -gx VISUAL $EDITOR
set -U SHELL /bin/fish

# Set PATH
set --universal fish_user_paths $fish_user_paths /opt/homebrew/bin "/Applications/Postgres.app/Contents/Versions/latest/bin" "/Library/Frameworks/Python.framework/Versions/3.12/bin"

# Initioalize other apps
eval "$(/opt/homebrew/bin/brew shellenv)"
zoxide init fish | source
starship init fish | source
