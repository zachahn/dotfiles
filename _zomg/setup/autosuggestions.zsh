[ ! -d "$HOME/.zomg/vendor/zsh-autosuggestions" ] \
  && git clone \
    https://github.com/zsh-users/zsh-autosuggestions.git \
    ~/.zomg/vendor/zsh-autosuggestions

source ~/.zomg/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
