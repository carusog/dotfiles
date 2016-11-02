" ============================================================================
" .vimrc {{{
" ============================================================================
"
" Author: Giuseppe Caruso <giuseppe@bonsai-studio.net>
" Source: https://github.com/carusog/dotfiles
"
" }}}
" ============================================================================
" be iMproved {{{
" ============================================================================

set nocompatible    " set Vim not to be compatible with Vi 
let mapleader=","   " change the leader to be a comma vs slash
filetype off

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================
"
" vim-plug is a very nice, minimalistic Vim plugin manager you can find at 
" https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

" Plug 'junegunn/vim-easy-align'

" Browsing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Colors
Plug 'junegunn/seoul256.vim'

" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()

" }}}
" ============================================================================
" GUI {{{
" ============================================================================

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 233

if has('gui_running')
  set guifont=Menlo:h14 columns=80 lines=40
  silent! colo seoul256
else
  silent! colo seoul256
endif


" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

noremap <space> za
noremap <leader><space> nohls

" }}}
" ============================================================================
" vim: set foldmethod=marker foldlevel=0:
