function cat --description "Display contents of a file"
    if isatty && type bat >/dev/null
        bat $argv
    else
        command cat $argv
    end
end
