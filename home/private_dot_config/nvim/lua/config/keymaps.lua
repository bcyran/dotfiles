-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

map("n", "<leader>h", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split vertical" })

map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Grep files" })
map("n", "<leader>fd", "<cmd>Telescope flutter commands<cr>", { desc = "Flutter commands" })

map("n", "dn", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "dp", diagnostic_goto(false), { desc = "Prev Diagnostic" })

map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
