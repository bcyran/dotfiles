local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

opt.whichwrap = "bs" -- do not wrap caret to next / previous line
opt.relativenumber = true
opt.scrolloff = 5
opt.title = true
opt.breakindent = true
opt.listchars = {
  eol = "¬",
  tab = ">-",
  space = "·",
  trail = "~",
  extends = ">",
  precedes = "<",
}
opt.incsearch = true
opt.spelllang = "en,pl"
opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.diagnostic.config({
  virtual_text = false,
})

-- Language-specific options
autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    opt.colorcolumn = "100"
  end
})

autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    opt.colorcolumn = "100"
  end
})

autocmd("FileType", {
  pattern = { "dart" },
  callback = function()
    opt.colorcolumn = "100"
  end
})
