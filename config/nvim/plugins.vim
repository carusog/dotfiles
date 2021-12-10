" Specify a directory for plugins
"
" Neovim
" - plug#begin(stdpath('data') . '/plugged')
" - it will be expanded to: ~/.local/share/nvim/plugged
"
" Vim
" - plug#begin('~/.vim/plugged')
"
" Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
call plug#begin(stdpath('data') . '/plugged')

" FZF
" ------------------------------------------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colors
" ------------------------------------------------------------------------------
Plug 'ayu-theme/ayu-vim'
Plug 'catppuccin/nvim'

call plug#end()
