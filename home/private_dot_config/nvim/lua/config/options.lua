-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.whichwrap = "bs" -- do not wrap caret to next / previous line
opt.relativenumber = true
opt.scrolloff = 5
opt.title = true
opt.breakindent = true
-- opt.listchars = {
--   eol = "¬",
--   tab = ">-",
--   space = "·",
--   trail = "~",
--   extends = ">",
--   precedes = "<",
-- }
opt.incsearch = true
opt.spelllang = "en,pl"
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.pumblend = 0
