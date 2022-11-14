#!/bin/sh

# where are we executing? We might have cloned into $HOME/dotfiles, or we might not
BASEDIR=$(dirname $(readlink -f "$0"))
if [ "$BASEDIR" != "$HOME/dotfiles" ]; then
  ln -s $BASEDIR $HOME/dotfiles
fi
cd $HOME

if [ ! -d "$HOME/dotfiles" ]; then
  echo "HOME/dotfiles/ directory must exist" >&2
  exit 1
fi

for f in $HOME/dotfiles/*; do
  filename=$(basename "$f")
  # ignore README and common_profile
  if [ "$filename" = "common_profile" ]; then
    continue
  fi
  if [ "$filename" = "README.md" ]; then
    continue
  fi
  # ignore profile_local and creds, because those are meant to be local overrides
  if [ "$filename" = "profile_local" ]; then
    continue
  fi
  if [ "$filename" = "creds" ]; then
    continue
  fi
  if [ -f "$f" ]; then
    target="$HOME/.${filename}"
    rm -f ${target}.bkup
    # remove a symlink
    [ -L ${target} ] && rm -f ${target}
    # if a file, save it to .bkup
    [ -f ${target} ] && mv ${target} ${target}.bkup
    ln -s ${f} ${target}
  fi
done 
