function up --description "Go n directories up"
    set -l counter $argv[1]

    if test -z $counter
        set counter 1
    end

    if ! string match -rq '^[0-9]+$' $counter
        echo "Usage: up [NUMBER]"
        return 1
    end

    set nwd (pwd)
    while test $counter -ge 1
        set nwd (dirname $nwd)
        set counter (math $counter - 1)
    end
    cd $nwd || return 1
end
