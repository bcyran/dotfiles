if vim.fn.executable("nix") ~= 1 then
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
        "nil",
      })
    end,
  },

  -- Add Nix treesitter syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "nix",
        })
      end
    end,
  },

  -- Setup LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
      },
    },
  },

  -- Setup formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = {
          "alejandra",
        },
      },
    },
  },
}
