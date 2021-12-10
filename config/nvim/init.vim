" My neovim settings {{{
" ------------------------------------------------------------------------------
" Author: Giuseppe Caruso <peppecaruso [at] gmail [dot] com>
" and the lovely internet folks keeping their dotfiles open to the community <3
" Source: https://github.com/carusog/dotfiles/config/nvim/
"
" }}}

" Window
" ------------------------------------------------------------------------------
set scrolloff=8
set number
set relativenumber

" Indentation
" ------------------------------------------------------------------------------
set expandtab										" use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set smartindent

" Mappings
" ------------------------------------------------------------------------------
let mapleader = "\<space>"
nnoremap <leader>pv :Vex<CR>
