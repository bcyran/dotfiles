---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>hl"] = { ":setlocal hls!<CR>", "toggle search highlighting" },
    ["<leader>cs"] = { ":let @/=''<CR>", "clear search" },
    ["<leader>ss"] = { ":setlocal spell!<CR>", "toggle spell check" },
    ["<leader>sw"] = { ":setlocal list!<CR>", "toggle show whitespace" },

    ["<leader>ms"] = { ":mksession!<CR>", "save session" },
    ["<leader>ls"] = { ":source Session.vim<CR>", "load session" },

    ["<leader>h"] = { ":split<CR>", "horizontal split" },
    ["<leader>v"] = { ":vsplit<CR>", "vertical split" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<leader>tt"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<leader>tt"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<leader>fd"] = { "<cmd> Telescope flutter commands <CR>", "flutter commands" },
  },
}

return M
