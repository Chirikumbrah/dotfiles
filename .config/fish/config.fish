if status is-interactive
    # Commands to run in interactive sessions can go here

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

    # Set PATH
    set --universal fish_user_paths $fish_user_paths /opt/homebrew/bin "/Applications/Postgres.app/Contents/Versions/latest/bin" "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$HOME/.config/scripts" "$HOME/.cargo/bin" $HOME/.krew/bin

    abbr ga 'git add'
    abbr gcm 'git commit -m'
    abbr gco 'git checkhout'
    abbr gd 'git diff'
    abbr gpl 'git pull'
    abbr gp 'git push'
    abbr gs "git status"

    # Initialize apps
    eval "$(/opt/homebrew/bin/brew shellenv)"
    zoxide init fish | source
    fzf --fish | source
    docker completion fish | source
end
