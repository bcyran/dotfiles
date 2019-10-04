" Use LaTeX flavor
let g:tex_flavor='latex'

" Wrap lines at 79 chars
set textwidth=79

" Display ruler at 80 column
set colorcolumn=80

" Disable conceal
let g:tex_conceal = ""

" Vimtex expression folding
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()
