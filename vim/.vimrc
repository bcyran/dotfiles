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
Plugin 'joshdick/onedark.vim'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'Yggdroot/indentLine'
Plugin 'w0rp/ale'
Plugin 'Shougo/deoplete.nvim'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'deoplete-plugins/deoplete-jedi'
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
set cursorline
set signcolumn=yes
set pumheight=10
set completeopt-=preview

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

" Buffer navigation
" Jump to buffer n by typing ngb
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile

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
let g:lightline={'colorscheme': 'onedark'}

" Lightline bufferline
set showtabline=2
let g:lightline#bufferline#show_number=1
let g:lightline.tabline={'left': [['buffers']], 'right': [['bufnum']]}
let g:lightline.component_expand={'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type={'buffers': 'tabsel'}

" Ale
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort'],
\}
let g:ale_fix_on_save=1

" Deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#max_list=20
function g:Multiple_cursors_before()
	call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
	call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" LaTeX
let g:tex_conceal = ""
