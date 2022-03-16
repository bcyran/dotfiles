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

" Lua framework
Plug 'nvim-lua/plenary.nvim'

" Colors and visual
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'seblj/nvim-tabline'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'

" Productivity
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-surround'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'moll/vim-bbye'
Plug 'nvim-telescope/telescope.nvim'
Plug 'abecodes/tabout.nvim'

" Syntax parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Code completion and linting
if executable('node') | Plug 'neoclide/coc.nvim', {'branch': 'release'} | endif

" Languages support
let g:polyglot_disabled=['latex']
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
if executable('latex') | Plug 'lervag/vimtex', {'for': 'tex'}| endif

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
if has('termguicolors')
    set termguicolors
endif
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
set wildignore+=*/.git*,*/node_modules*,*/venv*,*/__pycache__*,*.o,*~
set wildignore+=*.pyc,*/.idea*,*.egg-info*

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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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

" File tree
nnoremap <silent> <Leader>le :NvimTreeToggle<CR>
nnoremap <silent> <leader>lr :NvimTreeRefresh<CR>
nnoremap <silent> <leader>lf :NvimTreeFindFile<CR>

" Source my {vimrc,ftplugin} file
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>ss :source <C-r>=EvalueFtpluginPath()<CR><CR>

" Edit my {vimrc,ftplugin} file
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>es :tabe <C-r>=EvalueFtpluginPath()<CR><CR>

" Navigate between git hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Open file under cursor in split window
nnoremap <silent> <Leader>pf :vertical wincmd f<CR>

" Exit terminal mode with C-\
tnoremap <C-\> <C-\><C-n>

" Natural splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Goto tag
nnoremap <Leader>t :ta<Space>

" Telescope bindings
nnoremap <Leader>b <cmd>Telescope buffers<cr>
nnoremap <Leader>f <cmd>Telescope find_files<cr>
nnoremap <Leader>g <cmd>Telescope live_grep<cr>

" coc.nvim bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> cr <Plug>(coc-rename)
nmap <silent> gh :call <SID>ShowDocumentation()<CR>
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Or :call CocAction('runCommand', 'editor.action.organizeImport')
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Autoformat
nnoremap <silent> <Leader>af :Format<Cr>

" }}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGURATION                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" File tree sidebar (nvim-tree.lua)
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }

lua <<EOF
require('nvim-tree').setup({
    update_cwd = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        width = 40,
        auto_resize = true,
    },
    filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', 'venv', '__pycache__' }
    }
})
EOF

" gitsigns
lua <<EOF
require('gitsigns').setup()
EOF

" Lualine
lua <<EOF
require('lualine').setup({
    options = {
        theme = 'onedark',
        disabled_filetypes = { 'NvimTree' },
    },
    sections = {
        lualine_a = {
            'mode',
            'paste'
        },
        lualine_b = {
            {'filename', file_status = true},
        },
        lualine_c = {
            {'branch', icon = ''},
            {
                'diff',
                diff_color = {
                    added = {fg = '#98c379'},
                    modified = {fg = '#e5c07b'},
                    removed = {fg = '#e06c75'},
                },
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sources = {'coc'},
                diagnostics_color = {
                    error = {fg = '#e06c75'},
                    warn = {fg = '#e5c07b'},
                    info = {fg = '#61afef'},
                    hint = {fg = '#98c379'},
                },
            },
        },
        lualine_y = {
            'filetype',
        },
        lualine_z = {
            {'location', icon = ''},
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
EOF

" nvim-tabline
lua <<EOF
require('tabline').setup({
    no_name = '[No Name]',
    modified_icon = '',
    close_icon = '',
    separator = '',
    padding = 1,
    color_all_icons = false,
    always_show_tabs = false,
    right_separator = false,
    show_index = true,
    show_icon = true,
})
EOF

" Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,javascript,javascriptreact,svelte EmmetInstall
let g:user_emmet_leader_key=','

" Indent blankline
lua <<EOF
require('indent_blankline').setup({
    char = '¦',
    show_trailing_blankline_indent = false,
    buftype_exclude = {'terminal', 'help'},
})
EOF

" Vimtex
if executable('nvr') | let g:vimtex_compiler_progname='nvr' | endif
if executable('zathura') | let g:vimtex_view_method='zathura' | endif
let g:tex_flavor = 'latex'

" Treesitter
lua <<EOF
local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = 'maintained',
    highlight = { enable = true },
    indent = { enable = fales },
    refactor = {
        highlight_definitions = { enable = true },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
}
EOF

" tabout.nvim
lua <<EOF
require('tabout').setup()
EOF

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
