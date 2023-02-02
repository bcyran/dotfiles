function tree --description "Display directory structure as a tree"
    if isatty && type exa >/dev/null
        exa --tree $argv
    else
        command tree $argv
    end
end
