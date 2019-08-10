" Wrap lines at 79 chars
set textwidth=79

" Vimtex expression folding
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()
