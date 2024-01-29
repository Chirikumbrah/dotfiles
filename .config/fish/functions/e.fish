function e
    if count $argv >/dev/null
        $EDITOR $argv
    else
        $EDITOR .
    end
end
