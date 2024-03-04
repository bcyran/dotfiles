local options = {
  filetypes_denylist = {
    "gitcommit",
    "NvimTree",
    "help",
    "sagafinder",
    "sagaoutline",
  },
  min_count_to_highlight = 2,
}

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

return options
