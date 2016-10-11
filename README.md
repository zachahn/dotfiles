# Dotfiles

## Quick start guide

```
git clone git@github.com:zachahn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake
```

## Manual

- `rake`  
  runs all the following (nondestructive) tasks

- `rake link`  
  links all files beginning with `_` to the home directory  
  eg `_zshrc` to `~/.zshrc`

- `rake vim`  
  sets up vim plugins

- `rake zsh`  
  sets up Prezto

- `rake link:clean` (destructive)  
  removes symlinks to this directory
