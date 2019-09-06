#!/bin/sh

set -e

current_file=$(readlink -f "$0")
dotfiles_dir=$(dirname "$current_file")

for src_basename in _* ; do
  dest_basename=".${src_basename#?}"
  dest="$HOME/$dest_basename"
  src="$dotfiles_dir/$src_basename"

  echo "==> $dest"
  if [ -e "$dest" ] ; then
    echo "    already exists. skipping"
  else
    printf "    linking... "

    if ln -s "$src" "$dest" ; then
      echo "done"
    else
      echo "failed"
    fi
  fi
done
