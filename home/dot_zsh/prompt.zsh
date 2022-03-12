# Thanks to: https://gist.github.com/mislav/1712320

# Setup
autoload colors; colors;
setopt prompt_subst

# Settings
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Functions
# Determine prompt char
prompt_char() {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

# Show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

# Show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}

# If in a git repo, show dirty indicator + git branch
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$ZSH_THEME_GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Define prompt
PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m:%{$fg_bold[blue]%}%(!.%1~.%~)%{$fg_bold[cyan]%}$(git_custom_status)%{$reset_color%}$(prompt_char) '
