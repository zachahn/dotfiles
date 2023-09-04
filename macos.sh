#!/bin/sh

#     ____             __
#    / __ \____  _____/ /__
#   / / / / __ \/ ___/ //_/
#  / /_/ / /_/ / /__/ ,<
# /_____/\____/\___/_/|_|
#

defaults write com.apple.dock "tilesize" -int "36"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-delay" -float 0
killall Dock

#     __ __           __                         __
#    / //_/__  __  __/ /_  ____  ____ __________/ /
#   / ,< / _ \/ / / / __ \/ __ \/ __ `/ ___/ __  /
#  / /| /  __/ /_/ / /_/ / /_/ / /_/ / /  / /_/ /
# /_/ |_\___/\__, /_.___/\____/\__,_/_/   \__,_/
#           /____/

defaults write -g "InitialKeyRepeat" -int "15"
defaults write -g "KeyRepeat" -int "2"
