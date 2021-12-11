" My neovim settings
" ------------------------------------------------------------------------------
" Author: Giuseppe Caruso <peppecaruso [at] gmail [dot] com>
" and the lovely internet folks keeping their dotfiles open to the community <3
" Source: https://github.com/carusog/dotfiles/config/nvim/

" Plugins
" ------------------------------------------------------------------------------
source <sfile>:h/plugins.vim

" Window
" ------------------------------------------------------------------------------
set scrolloff=8
set number
set relativenumber
set nowrap
set cursorline
" Neovim defaults: listchars=tab:> ,trail:-,nbsp:+
set listchars=eol:$,tab:>-,trail:•,extends:>,precedes:<,nbsp:+
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" Colors
set termguicolors       " enable true colors support
let ayucolor="dark"     " for dark version of theme, also 'light' and 'mirage'
colorscheme ayu
" colorscheme catppuccin

" Indentation
" ------------------------------------------------------------------------------
set expandtab                                       " use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set smartindent

" Editing
" ------------------------------------------------------------------------------
set foldmethod=indent
set foldlevel=9999

" Searching
set smartcase

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
" Toggles foldings
nnoremap <leader><space> za
" Add new line without landing in isert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" Switch between buffers using alt+[left|right] arrows
nnoremap <silent><A-Right> :bn<CR>
inoremap <silent><A-Right> <C-O>:bn<CR>
nnoremap <silent><A-Left> :bp<CR>
inoremap <silent><A-Left> <C-O>:bp<CR>

" Underline the current line with '=', '-', or '~'
nmap <silent> <leader>u= :t.\|s/./=/g\|:nohls<cr>
nmap <silent> <leader>u- :t.\|s/./-/g\|:nohls<cr>
nmap <silent> <leader>u~ :t.\|s/./\~/g\|:nohls<cr>

" Autocommands
" ------------------------------------------------------------------------------
augroup filetype_settings
autocmd!
" Dynamically open help windows at the top 
" if there's more than one window in current tab, 
" or on the right, if there's only one window
autocmd FileType help if winnr('$') > 2 | wincmd K | else | wincmd L | endif
augroup END
