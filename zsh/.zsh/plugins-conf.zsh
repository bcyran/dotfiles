# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)

# History substring search
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=none
