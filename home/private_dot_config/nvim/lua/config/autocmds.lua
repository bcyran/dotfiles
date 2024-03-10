-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Language-specific options
autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    opt.colorcolumn = "100"
  end,
})

autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    opt.colorcolumn = "100"
  end,
})

autocmd("FileType", {
  pattern = { "dart" },
  callback = function()
    opt.colorcolumn = "100"
  end,
})
