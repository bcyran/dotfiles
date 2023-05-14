local M = {}

M.cmp = {
  mapping = {
    ["<C-y>"] = require("cmp").mapping.confirm {
      behavior = require("cmp").ConfirmBehavior.Replace,
      select = false,
    },
  },
}

M.blankline = {
  show_first_indent_level = true,
  show_current_context_start = false,
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- shell
    "shellcheck",
    "shfmt",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- python
    "pyright",
    "flake8",
    "isort",
    "mypy",
    "black",

    -- rust
    "rust-analyzer",
    "rustfmt",

    -- go
    "gopls",
  },
}

M.nvimtree = {
  update_cwd = true,

  view = {
    adaptive_size = true,
    width = {
      min = 30,
      max = 45,
    },
  },

  git = {
    enable = true,
  },

  renderer = {
    root_folder_label = true,
    highlight_git = true,
    highlight_opened_files = "icon",
    group_empty = true,

    icons = {
      show = {
        git = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },

  filters = {
    dotfiles = false,
    custom = {
      "^\\.git$",
      "node_modules",
      "venv",
      "__pycache__",
      "^\\.mypy_cache",
      "^\\.null-ls",
    },
  },

  modified = {
    show_on_dirs = false,
  },
}

return M
