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

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cj", "<cmd>TSJJoin<cr>", desc = "Join lines" },
      { "<leader>cs", "<cmd>TSJSplit<cr>", desc = "Split lines" },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
