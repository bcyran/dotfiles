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

    ["<C-h>"] = { ":<C-U>TmuxNavigateLeft<CR>", "navigate left to the split or tmux pane" },
    ["<C-j>"] = { ":<C-U>TmuxNavigateDown<CR>", "navigate down to the split or tmux pane" },
    ["<C-k>"] = { ":<C-U>TmuxNavigateUp<CR>", "navigate up to the split or tmux pane" },
    ["<C-l>"] = { ":<C-U>TmuxNavigateRight<CR>", "navigate right to the split or tmux pane" },
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
