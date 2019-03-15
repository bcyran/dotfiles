# zsh settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
zstyle :compinstall filename '/home/bazyli/.zshrc/comp'
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

# Antibody
source <(antibody init)
antibody bundle < ~/.zsh/plugins.txt

# Prompt theme (modified oh-my-zsh/gentoo)
source ~/.zsh/sajran.zsh-theme

# Load bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
