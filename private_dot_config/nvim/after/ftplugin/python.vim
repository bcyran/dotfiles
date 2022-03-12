" Highlight everything
let python_highlight_all = 1
let g:coc_root_patterns = ["pyrightconfig.json", "requirements.txt", ".venv", "pyproject.toml", "setup.cfg", "setup.py", ".git"]
let g:python3_host_prog = "~/.virtualenvs/nvim/bin/python3"

" Show ruler at 100 chars
set colorcolumn=100

" Autoformat with organizing imports
nnoremap <silent> <Leader>af :Or<Cr>:Format<Cr>
