#!/bin/bash
rsync --recursive --verbose --exclude '.git' $HOME/tmpdotfiles/ $HOME/
rm -r $HOME/tmpdotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
