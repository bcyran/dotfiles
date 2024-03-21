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

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      position = "right",
      window = {
        winblend = 0,
      },
    },
    keys = {
      { "<leader>cu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
    },
  },

  {
    "nvim-cmp",
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(v)
        return not vim.tbl_contains({ "luasnip" }, v.name)
      end, opts.sources)
    end,
  },
}
