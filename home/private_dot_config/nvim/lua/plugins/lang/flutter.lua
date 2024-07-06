return {
  -- Add Dart & related treesitter syntaxes
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- See:
      -- * https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
      -- * https://github.com/nvim-treesitter/nvim-treesitter/issues/5868
      -- * https://github.com/UserNobody14/tree-sitter-dart/issues/60
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      ---@diagnostic disable: inject-field
      parsers.dart = {
        install_info = {
          url = "https://github.com/UserNobody14/tree-sitter-dart",
          files = { "src/parser.c", "src/scanner.c" },
          revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4",
        },
      }

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "dart",
          "yaml",
        })
      end
    end,
  },

  -- LSP and more
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "tabedit",
      },
      widget_guides = {
        enabled = true,
      },
      lsp = {
        settings = {
          lineLength = 100,
        },
      },
    },
  },
}
