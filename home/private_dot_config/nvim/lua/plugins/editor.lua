return {
  {
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle", "TableModeEnable", "TableModeRealign" },
    keys = {
      { "<leader>tm", "<cmd>TableModeEnable<cr>", desc = "Toggle table mode" },
      { "<leader>tr", "<cmd>TableModeRealign<cr>", desc = "Realign table" },
      { "<leader>tt", "<cmd>Tableize<cr>", desc = "Tableize data" },
    },
  },
}
