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

vim.diagnostic.config({
  virtual_text = false,
})
