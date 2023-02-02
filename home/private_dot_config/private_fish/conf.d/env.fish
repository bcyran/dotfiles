# Private bin dirs
if test -d "~/bin"
    fish_add_path "/home/bazyli/bin"
end
if test -d "~/bin/local"
    fish_add_path "/home/bazyli/bin/local"
end

# Other private dirs
set -gx PRIV_CODE_DIR "/home/bazyli/Kod"
set -gx PRIV_SCREENSHOTS_DIR "/home/bazyli/Obrazy/Zrzuty ekranu"
set -gx PRIV_WALLPAPERS_DIR "/home/bazyli/Obrazy/Tapety"

# SSG agent
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket" 

# Default editors anc viewers
if type nvim > /dev/null
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else
    set -gx EDITOR vim
    set -gx VISUAL vim
end
set -gx PAGER less
set -gx DIFFPROG 'nvim -d'

# Go setup
set -gx GOPATH "$PRIV_CODE_DIR/go"
fish_add_path $GOPATH

if test -f ~/.profile_local.fish
    source ~/.profile_local.fish
end
