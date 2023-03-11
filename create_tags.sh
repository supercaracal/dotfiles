#!/bin/bash

set -euo pipefail

readonly TMPFILE='_tags'
readonly TAGFILE='.tags'
readonly SRC_DIRS="$HOME/vcs"

touch $HOME/$TAGFILE $HOME/$TMPFILE

ctags\
  --exclude=.git\
  --exclude=node_modules\
  --exclude=.bundle\
  --exclude=tmp\
  --exclude=log\
  --exclude=git\
  --exclude=WSL2-Linux-Kernel\
  -Rf\
  $HOME/$TMPFILE\
  $SRC_DIRS

rm $HOME/$TAGFILE
mv $HOME/$TMPFILE $HOME/$TAGFILE
