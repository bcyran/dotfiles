function fish_title
    set -q argv[1]; or set argv fish
    echo $USER@(hostname) (prompt_pwd): $argv[1]
end
