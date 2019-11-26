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
    # test for symlink (-L), the for the existence of a file or directory (-e)
    # finally, create symlink to files or folder at this folder location
    echo "checking or creating ${2}"
    test -L "${HOME}/$2" || test -e "${HOME}/$2" || ln -s "$(pwd)/$1" "${HOME}/$2"
}

# ===============================================
# vim
# ===============================================
echo "Check for .vim existence. Eventually move to bkp before moving vim to .vim"
# TODO: Make this a function to be used inside `ensure_link` for all files/folders
test ! -d ${HOME}/.vim || \
    echo "${$?}: I've found an existing .vim folder, setting up bkp" && \
    mkdir -p ${HOME}/.dotfiles_bkp && \
    mv ${HOME}/.vim $_

ensure_link "vim" ".vim"
ensure_link "vim/vimrc" ".vimrc"

# ===============================================
# zsh
# ===============================================
echo "Check for .zshrc existence. Eventually move to bkp folder" 
test ! -f ${HOME}/.zshrc || \
    echo "Found a .zshrc file. I am moving it to back up folder" && \
    mv ${HOME}/.zshrc ${HOME}/.dotfiles_bkp/

ensure_link ".zshrc" ".zshrc"
