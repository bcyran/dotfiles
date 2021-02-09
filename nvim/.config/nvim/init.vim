""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Load vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins directory
call plug#begin('~/.local/share/nvim/plugged')

" Colors and visual
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'RRethy/vim-illuminate'

" Productivity
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdtree'
Plug 'moll/vim-bbye'
if executable('ctags') | Plug 'ludovicchabant/vim-gutentags' | endif
if executable('fzf') | Plug 'junegunn/fzf.vim' | endif

" Code completion and linting
Plug 'w0rp/ale'
if executable('node') | Plug 'neoclide/coc.nvim', {'branch': 'release'} | endif

" Languages support
let g:polyglot_disabled=['latex']
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
if executable('latex') | Plug 'lervag/vimtex', {'for': 'tex'}| endif
Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}

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
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
let g:onedark_terminal_italics=1
syntax on
colorscheme onedark

" Searching
set incsearch
set ignorecase
set smartcase

" Splits
set splitbelow
set splitright
set noequalalways

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

" Backup file
set backupdir=~/.local/share/nvim/backup
call mkdir(&backupdir, 'p')
set backup

" Persistent undo
set undodir=~/.local/share/nvim/undo
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
let nosaveview=['help', 'netrw', 'vim-plug', 'gitcommit', '']
augroup AutoSaveView
    autocmd!
    autocmd BufWinLeave,BufLeave,BufWritePost ?* nested
        \ if index(nosaveview, &ft) < 0 | silent! mkview!
    autocmd BufWinEnter ?*
        \ if index(nosaveview, &ft) < 0 | silent! loadview | call lightline#update()
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
nnoremap <silent> <Leader>le :NERDTreeToggle<CR>

" Source my {vimrc,ftplugin} file
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>ss :source <C-r>=EvalueFtpluginPath()<CR><CR>

" Edit my {vimrc,ftplugin} file
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>es :tabe <C-r>=EvalueFtpluginPath()<CR><CR>

" Navigate between ale errors
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Navigate between git hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Go to file under cursor
nnoremap <silent> <Leader>gf :vertical wincmd f<CR>

" Move vertically by visual line
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Exit terminal mode with C-\
tnoremap <C-\> <C-\><C-n>

" Natural splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer listing and switching
if executable('fzf')
    nnoremap <Leader>b :Buffers<CR>
else
    nnoremap <Leader>b :buffers<CR>:buffer<space>
endif

" Quick file searching
if executable('fzf')
    nnoremap <expr> <Leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
else
    nnoremap <Leader>f :find<space>
endif

" Goto tag
nnoremap <Leader>t :ta<Space>

" coc.nvim bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call <SID>ShowDocumentation()<CR>
nmap <silent> cr <Plug>(coc-rename)
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Vista
nnoremap <silent> <Leader>ve :Vista!!<CR>

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

" Statusline
set laststatus=2
set ttimeout ttimeoutlen=30
set noshowmode
let g:lightline={
\   'colorscheme': 'onedark',
\   'active': {
\       'left': [
\           ['mode', 'paste'], ['gitbranch'], ['filename', 'readonly', 'modified']
\       ],
\       'right': [
\           ['percent', 'lineinfo'], ['linter_warnings', 'linter_errors'], ['filetype']
\       ]
\   },
\   'component_function': {
\       'gitbranch': 'FugitiveHead',
\       'linter_warnings': 'LinterWarnings',
\       'linter_errors': 'LinterErrors',
\   },
\}

" Ale
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'black'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\}
let g:ale_linters={
\   'javascript': [],
\   'javascriptreact': [],
\   'rust': [],
\}
let g:ale_fix_on_save=1
let g:ale_python_black_options='-t py38'

" Illuminate
let g:Illuminate_delay=500
let g:Illuminate_ftblacklist = ['nerdtree', 'vista', 'help', 'python']

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,javascript,javascriptreact EmmetInstall
let g:user_emmet_leader_key=','

" Indentline
let g:indentLine_first_char='┊'
let g:indentLine_char='┊'
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_faster=1

" Gutentags
let g:gutentags_cache_dir='~/.local/share/nvim/tags/'
let g:gutentags_ctags_auto_set_tags=1

" Vimtex
if executable('nvr') | let g:vimtex_compiler_progname='nvr' | endif
if executable('zathura') | let g:vimtex_view_method='zathura' | endif
let g:tex_flavor = 'latex'


" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Get the path for the ftplugin of the current file.
function! EvalueFtpluginPath()
    return '$HOME/.config/nvim/after/ftplugin/' . &filetype . '.vim'
endfunction

" Netrw toggling
function! ToggleNetrw()
    let i = bufnr('$')
    let wasOpen = 0
    while (i >= 1)
        if (getbufvar(i, '&filetype') == 'netrw')
            silent exe 'bwipeout ' . i
            let wasOpen = 1
        endif
        let i-=1
    endwhile
    if !wasOpen
        silent Lexplore
    endif
endfunction

" Sum coc and ALE warnings
function! LinterWarnings()
    let l:ale_counts = ale#statusline#Count(bufnr(''))
    let l:ale_warnings = l:ale_counts.warning + l:ale_counts.style_warning
    let l:coc_warnings = get(get(b:, 'coc_diagnostic_info', {}), 'warning', 0)
    let l:warnings = l:ale_warnings + l:coc_warnings
    return l:warnings == 0 ? '' : printf('W: %d', l:warnings)
endfunction

" Sum coc and ALE errors
function! LinterErrors()
    let l:ale_counts = ale#statusline#Count(bufnr(''))
    let l:ale_errors = l:ale_counts.error + l:ale_counts.style_error
    let l:coc_errors = get(get(b:, 'coc_diagnostic_info', {}), 'error', 0)
    let l:errors = l:ale_errors + l:coc_errors
    return l:errors == 0 ? '' : printf('E: %d', l:errors)
endfunction

" Show either coc or vim documentation
function! s:ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
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
