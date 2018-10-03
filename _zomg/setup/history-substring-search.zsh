# Install
[ ! -d "$HOME/.zomg/vendor/zsh-history-substring-search" ] \
  && git clone \
    https://github.com/zsh-users/zsh-history-substring-search.git \
    ~/.zomg/vendor/zsh-history-substring-search

source ~/.zomg/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh

HISTORY_SUBSTRING_SEARCH_FUZZY="true"

bindkey -M "emacs" '^[[A' history-substring-search-up
bindkey -M "emacs" '^[[B' history-substring-search-down
