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

for src_basename in _* ; do
  dest_basename=".${src_basename#?}"
  dest="$HOME/$dest_basename"
  src="$dotfiles_dir/$src_basename"

  if [ -e "$dest" ] ; then
    if [ -L "$dest" ] ; then
      echo "GOOD - NOOP: $dest"
    else
      echo "FAIL - CONFLICT: $dest"
    fi
  else
    if ln -s "$src" "$dest" ; then
      echo "GOOD - MADE: $dest"
    else
      echo "FAIL - LINK ERR: $dest"
    fi
  fi
done
