return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- nvim
        "vim",
        "lua",
        -- web
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        -- core dev
        "dart",
        -- markup
        "json",
        "yaml",
        -- text
        "markdown",
        "markdown_inline",
      },
      indent = {
        enable = true,
        disable = { "dart" },
      },
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select outer function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ac"] = { query = "@class.outer", desc = "Select outer class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_sourrounding_whitespace = true,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
          },
        },
        lsp_interop = {
          enable = true,
          border = "single",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dc"] = "@class.outer",
          },
        },
      },
      refactor = {
        highlight_definitions = {
          enable = false,
          clear_on_cursor_move = false,
        },
      },
    },
    init = function()
      local parser = require("nvim-treesitter.parsers").get_parser_configs()
      parser.dart = {
        install_info = {
          url = "https://github.com/UserNobody14/tree-sitter-dart",
          files = { "src/parser.c", "src/scanner.c" },
          revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4", -- The last commit before the snail speed
        },
      }
    end,
  },
}
