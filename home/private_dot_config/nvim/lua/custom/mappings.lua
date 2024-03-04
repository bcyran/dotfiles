---@type MappingsTable
local M = {}

local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

local function close_buffer()
  if vim.bo.filetype == "terminal" then
    require("nvchad.tabufline").close_buffer()
  else
    require("mini.bufremove").delete()
  end
end

M.general = {
  n = {
    ["<leader>x"] = { close_buffer, "Close buffer" },
    ["<C-q>"] = { toggle_quickfix, "toggle quickfix list" },

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
  t = {
    ["<Esc>"] = { "<C-\\><C-n>", "exit terminal mode" },
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

M.copilot = {
  plugin = true,

  n = {
    ["<leader>cp"] = { ":Copilot panel<CR>", "copilot panel" },
  },
}

M.conform = {
  plugin = true,

  n = {
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "format buffer",
    },
  },
}

M.codeium = {
  plugin = true,

  i = {
    ["<C-y>"] = {
      function()
        vim.fn.feedkeys(vim.fn["codeium#Accept"](), "")
      end,
      "accept Codeium suggestion",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
    ["<C-a>"] = {
      function()
        vim.fn["codeium#Complete"]()
      end,
      "manually trigger Codeium suggestion",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
    ["<C-n>"] = {
      function()
        vim.fn["codeium#CycleCompletions"](1)
      end,
      "next Codeium suggestion",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
    ["<C-p>"] = {
      function()
        vim.fn["codeium#CycleCompletions"](-1)
      end,
      "previous Codeium suggestion",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
  },
  n = {
    ["<leader>at"] = { ":CodeiumToggle<CR>", "toggle Codeium" },
  },
}

M.illuminate = {
  plugin = true,

  n = {
    ["sn"] = {
      function()
        require("illuminate").goto_next_reference(true)
      end,
      "Go to the next reference",
    },

    ["sp"] = {
      function()
        require("illuminate").goto_prev_reference(true)
      end,
      "Go to the previous reference",
    },
  },
}

M.lspsaga = {
  plugin = true,

  n = {
    ["gr"] = { ":Lspsaga finder<CR>", "LSP references" },
    ["dn"] = { ":Lspsaga diagnostic_jump_next<CR>", "go to next diagnostics item" },
    ["dp"] = { ":Lspsaga diagnostic_jump_prev<CR>", "go to previous diagnostics item" },
    ["<leader>ic"] = { ":Lspsaga incoming_calls<CR>", "incoming calls" },
    ["<leader>oc"] = { ":Lspsaga outgoing_calls<CR>", "outgoing calls" },
    ["<leader>ca"] = { ":Lspsaga code_action<CR>", "LSP code action" },
    ["<leader>ol"] = { ":Lspsaga outline<CR>", "Symbols outline" },
  },
}

return M
