" Highlight everything
let python_highlight_all = 1

" Wrap lines at 79 chars
set textwidth=79

" Comment and uncomment blocks of code
vnoremap <Leader>cc :'<,'>normal ^i# <CR>
vnoremap <Leader>cu :'<,'>normal ^xx<CR>
