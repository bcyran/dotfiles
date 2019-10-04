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

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/echodoc.vim'

" Language specific plugins
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }

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
set number relativenumber
set wildmenu
set lazyredraw
set showmatch
set cursorline
set signcolumn=yes
set pumheight=10
set completeopt-=preview
set scrolloff=5
set shortmess+=c
set title

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftround
set breakindent

" Display whitespace
set listchars=eol:¬,tab:>-,space:·,trail:~,extends:>,precedes:<

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
set path=**
set wildignore+=*/.git/*,*/node_modules/*,*/venv/*,*/__pycache__/*,*.o,*~
set wildignore+=*.pyc,*/.idea/*

" Auto read modifications from outside
set autoread

" Auto read local 'vimrc' files
set exrc
set secure

" Persistent undo
set undolevels=1000
set undoreload=10000
call mkdir(&undodir, 'p')
set undofile

" Folding
set foldmethod=indent
set nofoldenable
set foldignore=

" Views
set viewoptions=cursor,folds,slash,unix
let nosaveview=['help', 'netrw', 'vim-plug', 'gitcommit']
augroup AutoSaveView
    autocmd!
    autocmd BufWinLeave,BufLeave,BufWritePost ?* nested
        \ if index(nosaveview, &ft) < 0 | silent! mkview!
    autocmd BufWinEnter ?*
        \ if index(nosaveview, &ft) < 0 | silent! loadview
augroup end

" Enable modelines
set modeline

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

" Toggle relativenumber
nnoremap <silent> <Leader>rn :setlocal relativenumber!<CR>

" Toggle list (displaying whitespace)
nnoremap <silent> <Leader>sw :set list!<CR>

" Save current session
nnoremap <silent> <Leader>ms :mksession!<CR>

" Load saved session
nnoremap <silent> <Leader>ls :source Session.vim<CR>

" Toggle netrw
nnoremap <silent> <Leader>le :call ToggleNetrw()<CR>

" Source my {vimrc,ftplugin} file
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>ss :source <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Edit my {vimrc,ftplugin} file
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>es :tabe <C-r>=Evaluate_ftplugin_path()<CR><CR>

" Navigate between ale errors
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Go to file under cursor
nnoremap <silent> <Leader>gf :vertical wincmd f<CR>

" Move vertically by visual line
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Natural splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer listing and switching
nnoremap <Leader>b :ls<CR>:b<Space>

" Quick file searching
nnoremap <Leader>f :find<Space>

" Goto tag
nnoremap <Leader>t :ta<Space>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGURATION                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" File tree sidebar
let g:netrw_winsize=-24
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_browse_split=4
let g:netrw_list_hide= '.*\.git/.*,.*node_modules/.*,.*venv/.*,.*__pycache__/.*,.*/\.o,
\   .*~,.*\.pyc,.*\.vim,.*\.idea/.*'

" Lightline
set laststatus=2
set ttimeout ttimeoutlen=30
set noshowmode
let g:lightline={
\   'colorscheme': 'onedark',
\   'active': {
\       'left': [
\           ['mode', 'paste'], ['readonly', 'filename', 'branch', 'modified'], ['linter']
\       ],
\       'right': [
\           ['lineinfo'], ['percent'],
\           ['fileformat', 'fileencoding', 'filetype']
\       ]
\   },
\   'component_function': {
\       'linter': 'LinterStatus',
\       'branch': 'fugitive#head'
\   }
\}

" Ale
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort'],
\}
let g:ale_fix_on_save=1

" Deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#max_list=20

" Illuminate
let g:Illuminate_delay=500

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','

" Indentline
let g:indentLine_first_char='┊'
let g:indentLine_char='┊'
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_faster=1

" Gutentags
let g:gutentags_cache_dir='/home/bazyli/.local/share/nvim/tags/'
let g:gutentags_ctags_auto_set_tags=1

" Vimtex
let g:vimtex_compiler_progname='nvr'
let g:vimtex_view_method='zathura'

" Polyglot
let g:polyglot_disabled=['latex']

" Echodoc
let g:echodoc#enable_at_startup=1
let g:echodoc#type='echo'

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Get the path for the ftplugin of the current file.
function! Evaluate_ftplugin_path()
    return "$HOME/.config/nvim/after/ftplugin/" . &filetype . ".vim"
endfunction

" Count ALE linting errors to display in the lightline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE', all_non_errors, all_errors
    \)
endfunction

" Netrw toggling
function! ToggleNetrw()
        let i = bufnr("$")
        let wasOpen = 0
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
                let wasOpen = 1
            endif
            let i-=1
        endwhile
    if !wasOpen
        silent Lexplore
    endif
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
" - https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb

" }}}


" vim:foldmethod=marker:foldlevel=0:foldenable
