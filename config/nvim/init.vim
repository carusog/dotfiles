" My neovim settings {{{
" ------------------------------------------------------------------------------
" Author: Giuseppe Caruso <peppecaruso [at] gmail [dot] com>
" and the lovely internet folks keeping their dotfiles open to the community <3
" Source: https://github.com/carusog/dotfiles/config/nvim/
"
" }}}

" Plugins
" ------------------------------------------------------------------------------
source <sfile>:h/plugins.vim

" Window
" ------------------------------------------------------------------------------
set scrolloff=8
set number
set relativenumber
" Colors
set termguicolors       " enable true colors support
let ayucolor="dark"     " for dark version of theme, also 'light' and 'mirage'
colorscheme ayu
" colorscheme catppuccin


" Indentation
" ------------------------------------------------------------------------------
set expandtab										" use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set smartindent

" Mappings
" ------------------------------------------------------------------------------
let mapleader = "\<space>"
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>pv :Vex<CR>
nnoremap <C-p> :GFiles<CR> 
nnoremap <leader>pf :Files<CR> 
nnoremap <C-j> :cnext<CR> 
nnoremap <C-k> :cprev<CR> 
