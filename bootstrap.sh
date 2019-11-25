#!/bin/bash
# THIS IS A WORK IN PROGRESS
# BE CAREFUL, DAMMIT™
#
# shamelessly ripped off from @SJL dotfiles
# https://bitbucket.org/sjl/dotfiles/src/default/bin/bootstrap.sh 

set -e
# uncomment for debugging
set -x

# tests if a symlink to your conf file is already in place otherwise,
# it will create it, only if availabe in dotfiles
function ensure_link {
    # test for symlink THEN test if conf file is in dotfiles THEN create symlink
    # if any of the first two checks will fail, symlink will not be created
    echo "checking or creating ${2}"
    test -L "${HOME}/$2" || test ! -e "${HOME}/$1" || ln -s "${HOME}/$1" "${HOME}/$2"
}

# vim
echo "Check for .vim existence. Eventually move to bkp before moving vim to .vim"
test ! -d ~/.vim || \
	echo "setting up bkp" && \
	mkdir -p ~/.dotfiles_bkp && \
	mv ~/.vim $_ && \
	ln "./vim" "${HOME}/.vim"

echo "Just move DT vim to .vim"
test -d ~/.vim || \
	echo "There was no such a directory, so we are creating symlink" && \
	ln -s "./vim" "${HOME}/.vim"

ensure_link "./vim/vimrc" "${HOME}/.vimrc" 

# zsh

echo "Check for .zshrc existence. Eventually move to bkp folder" 
test ! -f ${HOME}/.zshrc || \
	echo "Found a .zshrc file. I am moving it to back up folder" && \
	mv ${HOME}/.zshrc ${HOME}/.dotfiles_bkp/

ensure_link "./.zshrc" "${HOME}/.zshrc"


