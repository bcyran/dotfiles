""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins directory
call plug#begin('~/.local/share/nvim/plugged')

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-jedi'

" Initialize plugin system
call plug#end()

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL VIM CONFIGURATION                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Disable compatible mode
set nocompatible

" Enable filetype plugin
filetype plugin indent on

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
nnoremap <silent> <Leader>hl :setlocal hls!<CR>

" Clear search
nnoremap <silent> <Leader>cs :let @/=''<CR>

" Select all text in buffer
nnoremap <silent> <Leader>a ggVG

" Toggle spell check
nnoremap <silent> <Leader>sc :setlocal spell!<CR>

" Save current session
nnoremap <silent> <Leader>ms :mksession<CR>

" Load saved session
nnoremap <silent> <Leader>ls :source Session.vim<CR>

" Source my {vimrc,ftplugin} file
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>ss :source <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Edit my {vimrc,ftplugin} file
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>es :tabe <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Natural splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer listing and switching
nnoremap <Leader>b :ls<cr>:b<space>

" Auto closing brackets
inoremap \[ \[\]<Left>
inoremap ( ()<Left>
inoremap { {}<Left>
" Auto expand grouping symbols
inoremap \[<CR> \[\]<Esc>i<CR><CR><Esc>ki<Tab>
inoremap (<CR> ()<Esc>i<CR><CR><Esc>ki<Tab>
inoremap {<CR> {}<Esc>i<CR><CR><Esc>ki<Tab>

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
    return "$HOME/.config/nvim/after/ftplugin/" . &filetype . ".vim"
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
" - https://www.reddit.com/r/vim/comments/coqoih/braces_autocomplete/ewku3k9

" }}}


" vim:foldmethod=marker:foldlevel=0
