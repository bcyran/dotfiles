if vim.fn.executable("python") ~= 1 then
  return {}
end

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
    cmd = { "VenvSelect", "VenvSelectCached", "VenvSelectCurrent" },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Auto select virtualenv Nvim open",
        pattern = "*",
        callback = function()
          local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
          if venv ~= "" then
            require("venv-selector").retrieve_from_cache()
          end
        end,
        once = true,
      })
    end,
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
