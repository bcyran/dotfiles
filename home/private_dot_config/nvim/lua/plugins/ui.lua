return {
  {
    "RRethy/vim-illuminate",
    lazy = false,
    init = function()
      require("illuminate").configure({
        filetypes_denylist = {
          "gitcommit",
          "NvimTree",
          "help",
          "sagafinder",
          "sagaoutline",
        },
        min_count_to_highlight = 2,
      })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
    keys = {
      {
        "en",
        function()
          require("illuminate").goto_next_reference(true)
        end,
        { desc = "Next reference" },
      },
      {
        "ep",
        function()
          require("illuminate").goto_prev_reference(true)
        end,
        { desc = "Prev reference" },
      },
    },
  },

  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = false,
      stop_eof = false,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
      easing_function = "quadratic",
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
  },

  {
    "tiagovla/scope.nvim",
    config = true,
  },

  {
    "folke/persistence.nvim",
    dependencies = { "tiagovla/scope.nvim" },
    opts = {
      pre_save = function()
        vim.cmd([[ScopeSaveState]])
      end,
    },
    keys = {
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
          vim.cmd([[ScopeLoadState]])
        end,
        { desc = "Load last session" },
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {
      excluded_filetypes = {
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
        "neo-tree",
        "lazy",
        "mason",
      },
      handlers = {
        cursor = false,
      },
    },
  },

  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      hide = {
        only_win = true,
      },
    },
  },
}
