#!/bin/sh

set -e

# https://stackoverflow.com/a/1116890
cross_platform_readlink_f() {
  TARGET_FILE=$1

  cd "$(dirname "$TARGET_FILE")"
  TARGET_FILE=$(basename "$TARGET_FILE")

  # Iterate down a (possible) chain of symlinks
  while [ -L "$TARGET_FILE" ]
  do
      TARGET_FILE="$(readlink "$TARGET_FILE")"
      cd "$(dirname "$TARGET_FILE")"
      TARGET_FILE="$(basename "$TARGET_FILE")"
  done

  # Compute the canonicalized name by finding the physical path
  # for the directory we're in and appending the target file.
  PHYS_DIR=$(pwd -P)
  RESULT=$PHYS_DIR/$TARGET_FILE
  echo "$RESULT"
}

current_file=$(cross_platform_readlink_f "$0")
dotfiles_dir=$(dirname "$current_file")

for dest in "$HOME"/.* ; do
  if [ -h "$dest" ] ; then
    src=$(cross_platform_readlink_f "$dest")
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
