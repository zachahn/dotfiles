#!/bin/sh

set -e

current_file=$(readlink -f "$0")
dotfiles_dir=$(dirname "$current_file")

for dest in "$HOME"/.* ; do
  if [ -h "$dest" ] ; then
    src=$(readlink -f "$dest")
    src_dirname=$(dirname "$src")
    echo "==> $dest"
    echo "    $src"

    if [ "$src_dirname" = "$dotfiles_dir" ] ; then
      printf "    deleting... "
      if rm "$dest" ; then
        echo "done"
      else
        echo "failed"
      fi
    else
      echo "    skipping"
    fi
  fi
done
