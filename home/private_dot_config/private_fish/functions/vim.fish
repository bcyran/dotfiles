function vim --description "Run nvim or vim editor"
    if type nvim > /dev/null
        nvim $argv
    else
        command vim $argv
    end
end
