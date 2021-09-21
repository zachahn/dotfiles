set fish_function_path $__fish_config_dir/fn $fish_function_path

set -Ux EDITOR vim

alias :e="vim"
alias be="bundle exec"
alias dots="cd ~/.dotfiles"
alias fishes="cd $__fish_config_dir"
alias it="git"
alias lah="ls -lah"
alias qgit="git"

if test -d ~/Code
  alias code="cd ~/Code"
else if test -d ~/code
  alias code="cd ~/code"
end

if test -d ~/Notes
  alias notes="cd ~/Notes"
else if test -d ~/notes
  alias notes="cd ~/notes"
end

if test -d ~/Downloads
  alias downloads="cd ~/Downloads"
end

if test -d ~/Desktop
  alias desktop="cd ~/Desktop"
end

switch (uname -s)
  case Darwin
    source $__fish_config_dir/darwin.fish
  case '*'
end

if test -f $__fish_config_dir/local.fish
  source $__fish_config_dir/local.fish
end
