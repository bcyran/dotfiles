" Vundle plugin manager
" Clone Vundle if it doesn't exist
if !filereadable($HOME . '/.vim/bundle/Vundle.vim/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
    exec '!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim/'
endif
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'itchyny/lightline.vim'
Plugin 'lervag/vimtex'
Plugin 'nvie/vim-flake8'
Plugin 'joshdick/onedark.vim'
call vundle#end()
filetype plugin indent on

" Syntax highlighting
syntax on
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
colorscheme onedark

" Fuzzy search
set path+=**
set wildignore+=*/node_modules/*,*/venv/*

" UI
set number
set wildmenu
set lazyredraw
set showmatch

" Indentation
set tabstop=4
set autoindent
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set smarttab

" Searching
set incsearch
set ignorecase
set smartcase

" Splits
set splitbelow
set splitright

" Spell check
set spelllang=pl,en

" File tree sidebar
let g:netrw_winsize=15
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_browse_split=4

" Lightline
set laststatus=2
set ttimeout ttimeoutlen=30
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
