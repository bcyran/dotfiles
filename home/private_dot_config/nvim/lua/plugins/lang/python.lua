return {
  -- Ensure external deps are installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "isort",
        "black",
        "flake8",
      })
    end,
  },

  -- Add Python & related treesitter syntaxes
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "python",
          "rst",
          "toml",
        })
      end
    end,
  },

  -- Setup LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "on",
                reportMissingImports = false,
                reportMissingTypeStubs = false,
              },
            },
          },
        },
      },
    },
  },

  -- Setup formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          "black",
          "isort",
        },
      },
      formatters = {
        black = {
          inherit = true,
          prepend_args = {
            "--line-length",
            "100",
          },
        },
        isort = {
          inherit = true,
          prepend_args = {
            "--profile",
            "black",
            "--line-length",
            "100",
            "--lines-after-imports",
            "2",
            "--combine-as",
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
      opts.linters_by_ft.python = {
        "flake8",
        -- "mypy",
      }
      opts.linters = opts.linters or {}
      opts.linters.flake8 = {
        args = {
          "--ignore",
          "E501,W503,E203",
          unpack(lint.linters.flake8.args),
        },
      }
      opts.linters.mypy = {
        args = {
          "--ignore-missing-imports",
          unpack(lint.linters.mypy.args),
        },
      }
      return opts
    end,
  },

  -- Virutalenv selector
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    branch = "regexp",
    opts = {
      settings = {
        options = {
          enable_cached_venvs = true,
          notify_user_on_venv_activation = true,
        },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
