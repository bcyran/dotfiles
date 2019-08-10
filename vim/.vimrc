""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE PLUGIN MANAGER                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

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
Plugin 'deoplete-plugins/deoplete-jedi'
call vundle#end()
filetype plugin indent on

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL VIM CONFIGURATION                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" User interface
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
set softtabstop=4
set autoindent
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set smarttab

" Syntax highlighting
syntax on
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
colorscheme onedark

" Searching
set incsearch
set ignorecase
set smartcase

" Splits
set splitbelow
set splitright

" Spell check
set spelllang=pl,en

" Buffers
set hidden

" Fuzzy search
set path+=**
set wildignore+=*/.git/*,*/node_modules/*,*/venv/*,*/__pycache__/*,*.o,*~,*.pyc

" Auto read modifications from outside
set autoread

" Folding
set foldmethod=indent
set nofoldenable
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM KEY BINDINGS AND COMMANDS                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Backslash is the real leader but space is mapped to it
let mapleader='\'
map <Space> \

" Toggle search highlighting
nnoremap <Leader>hl :setlocal hls!<CR>

" Clear search
nnoremap <Leader>cs :let @/=''<CR>

" Select all text in buffer
nnoremap <Leader>a ggVG

" Toggle spell check
nnoremap <Leader>sc :setlocal spell!<CR>

" Save current session
nnoremap <Leader>ms :mksession<CR>

" Load saved session
nnoremap <Leader>ls :source Session.vim<CR>

" Source my {vimrc,ftplugin} file
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>ss :source <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Edit my {vimrc,ftplugin} file
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>es :tabe <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Buffer navigation
" Jump to the nth buffer by typing ngb
let c = 1
while c <= 99
    execute "nnoremap " . c . "gb :" . c . "b\<CR>"
    let c += 1
endwhile

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGURATION                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

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

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Get the path for the ftplugin of the current file.
function! Evaluate_ftplugin_path()
    return "$HOME/.vim/after/ftplugin/" . &filetype . ".vim"
endfunction

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CREDITS                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" - https://github.com/amix/vimrc
" - https://gist.github.com/simonista/8703722
" - https://www.reddit.com/r/vim/comments/cog6tg/mappings_i_use_to_develop_my_vim_a_lil_more_easily/
" - https://superuser.com/a/693644
" - https://dougblack.io/words/a-good-vimrc.html

" }}}


" vim:foldmethod=marker:foldlevel=0
