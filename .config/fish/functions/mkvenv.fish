function mkvenv --wraps='python3 -m venv .venv && . .venv/bin/activate.fish' --description 'alias mkvenv=python3 -m venv .venv && . .venv/bin/activate.fish'
    python3 -m venv .venv $argv && . .venv/bin/activate.fish
end
