# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Options
setopt autocd # Change dir without cd
#setopt correct_all # Autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
bindkey -v # Vim mode

# Autocompletions with cache
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

# Autocompletion style
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select # select completions with arrow keys

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load antibody plugins and settings
source <(antibody init)
antibody bundle < ~/.zsh/plugins.txt
source ~/.zsh/plugins-conf.zsh

# Set prompt
source ~/.zsh/prompt.zsh
