---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  cmp = {
    style = "atom",
  },

  hl_override = highlights.override,
  hl_add = highlights.add,
  lsp_semantic_tokens = false,

  telescope = {
    style = "bordered",
  },

  statusline = {
    theme = "vscode_colored",
    overriden_modules = function(modules)
      table.insert(
        modules,
        13,
        (function()
          return " " .. vim.api.nvim_call_function("codeium#GetStatusString", {}) .. "  "
        end)()
      )
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
