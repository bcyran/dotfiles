local M = {}
-- local cmp_ui = require("core.utils").load_config().ui.cmp
local cmp = require "cmp"

M.cmp = {
  mapping = {
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<CR>"] = {},
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "nvim_lsp", group_index = 1 },
    { name = "nvim_lua", group_index = 1 },
    { name = "buffer", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  },
  completion = {
    completeopt = "menu,menuone,preview",
  },
  -- formatting = {
  --   format = function(_, item)
  --     local icons = require "nvchad.icons.lspkind"
  --     local icon = (cmp_ui.icons and icons[item.kind]) or ""
  --
  --     icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
  --     item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
  --     item.menu = nil
  --
  --     return item
  --   end,
  -- },
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
