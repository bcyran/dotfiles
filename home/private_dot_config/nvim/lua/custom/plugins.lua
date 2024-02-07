local overrides = require "custom.configs.overrides"
local settings = require "custom.settings"

---@type NvPluginSpec[]
local plugins = {
  {
    "sheerun/vim-polyglot",
    lazy = false,
  },

  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = require "custom.configs.persisted",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    custom_keys = {
      { "<leader>fm", desc = "format buffer" },
    },
    init = function()
      require("core.utils").load_mappings "conform"
    end,
    opts = require "custom.configs.conform",
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "custom.configs.lint"
    end,
  },

  -- language specific
  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = "rust",
    config = function()
      require "custom.configs.rustaceanvim"
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = require "custom.configs.flutter-tools",
  },

  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = { -- optional packages
      "neovim/nvim-lspconfig",
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require "custom.configs.go",
    event = { "CmdlineEnter" },
  },

  -- AI
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      require("core.utils").load_mappings "conform"
    end,
    opts = require "custom.configs.copilot",
    enabled = settings.copilot_enabled,
  },

  {
    "gptlang/CopilotChat.nvim",
    cmd = "CopilotChat",
    build = ":UpdateRemotePlugins",
    enabled = settings.copilot_enabled,
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    init = function()
      require("core.utils").load_mappings "codeium"
    end,
    config = function()
      vim.g.codeium_enabled = false
      vim.g.codeium_disable_bindings = true
    end,
    enabled = settings.codeium_enabled,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "custom.configs.treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-refactor",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.blankline,
  },

  {
    "abecodes/tabout.nvim",
    opts = require "custom.configs.tabout",
    lazy = false,
    priority = 10,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}

return plugins
