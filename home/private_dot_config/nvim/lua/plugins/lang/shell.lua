return {
  -- Ensure external deps are installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "shfmt",
        "shellcheck",
      })
    end,
  },

  -- Add shell treesitter syntaxes
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash",
          "fish",
        })
      end
    end,
  },

  -- Setup formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = {
          "shfmt",
          "shellcheck",
        },
        fish = {
          "fish_indent",
        },
      },
      formatters = {
        shfmt = {
          inherit = true,
          prepend_args = {
            "--indent",
            "4",
            "--binary-next-line",
            "--case-indent",
            "--space-redirects",
          },
        },
        shellcheck = {
          inherit = true,
          prepend_args = {
            "--enable=avoid-nullary-conditions,require-variable-braces,require-double-brackets",
            "--exclude=SC1091",
          },
        },
      },
    },
  },

  -- Setup linters
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")
      opts.linters_by_ft.sh = { "shellcheck" }
      opts.linters = opts.linters or {}
      opts.linters.shellcheck = {
        args = {
          "--enable=avoid-nullary-conditions,require-variable-braces,require-double-brackets",
          "--exclude=SC1091",
          unpack(lint.linters.shellcheck.args),
        },
      }
      return opts
    end,
  },
}
