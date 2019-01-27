" Vundle plugin manager
set nocompatible
filetype off
set rtp+=/home/bazyli/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'crusoexia/vim-monokai'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'itchyny/lightline.vim'
call vundle#end()
filetype plugin indent on

" Syntax highlighting
syntax on
colorscheme monokai

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
set hlsearch
set ignorecase
set smartcase

" File tree sidebar
let g:netrw_winsize=15
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_browse_split=4

" Lightline
set laststatus=2
set ttimeout ttimeoutlen=30
