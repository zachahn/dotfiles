#!/bin/bash

set -xe

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! test -d ~/.dotfiles; then
  git clone https://github.com/zachahn/dotfiles ~/.dotfiles
  sh ~/.dotfiles/link.sh
  brew bundle --global
  vim +PlugInstall +qa
fi

brew services start postgresql
brew services start redis
psql --dbname postgres --command "CREATE ROLE postgres LOGIN SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS;" || true

xattr -d -r com.apple.quarantine ~/Library/QuickLook
