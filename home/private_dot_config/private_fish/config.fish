if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Fish setup
fish_vi_key_bindings
set -gx fish_vi_force_cursor
set -gx fish_greeting
set -gx fish_cursor_default block
set -gx fish_cursor_insert line
set -gx fish_cursor_replace_one underscore
set -gx fish_cursor_visual block

# Tide setup
set -gx tide_right_prompt_items status cmd_duration context jobs node virtual_env rustc java go

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec ~/.hyprlandinitrc &> /dev/null
    else if test -z "$DISPLAY" -a "$XDG_VTNR" = 2
        exec startx -- -keeptty &> /dev/null
    end
end
