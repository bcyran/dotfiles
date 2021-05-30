# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Options
setopt autocd # Change dir without cd
#setopt correct_all # Autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
bindkey -v # Vim mode
bindkey '^R' history-incremental-pattern-search-backward # Search history on ctrl+r

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

# Load profile
[ -f ~/.profile ] && source ~/.profile

# Load aliases
[ -f ~/.aliases ] && source ~/.aliases

# Load antibody plugins and settings
source <(antibody init)
antibody bundle < ~/.zsh/plugins.txt
source ~/.zsh/plugins-conf.zsh

# Dynamic window title
case $TERM in
	xterm*|rxvt*)
		precmd () { print -Pn "\e]0;$USER@$HOST:$PWD\007" }
		preexec () { print -Pn "\e]0;$USER@$HOST:$PWD $1\007" }
	;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
