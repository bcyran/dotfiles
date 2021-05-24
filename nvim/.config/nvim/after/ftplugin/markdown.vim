" Conceal settings
" Indentline has to be disabled because it breaks conceal
" It's not needed when editing text anyway
let b:indentLine_enabled = 0
let b:indentLine_concealcursor = ''
set conceallevel=2
set concealcursor=""

" Line breaking
set linebreak
set breakindent
set showbreak=>\ 
