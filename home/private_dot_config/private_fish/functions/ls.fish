function ls --description "List contents of directory"
    if type exa > /dev/null
        exa --icons $argv
    else
        command ls $argv
    end
end
