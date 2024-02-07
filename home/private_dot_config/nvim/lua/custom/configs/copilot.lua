-- hide copilot suggestions when cmp menu is open
local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
  end)
end

local options = {
  panel = {
    enabled = true,
    auto_refresh = false,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-y>",
      accept_word = false,
      accept_line = "<C-m>",
      prev = "<C-p>",
      next = "<C-n>",
      dismiss = "<C-e>",
    },
  },
  filetypes = {
    rust = true,
    python = true,
    bash = true,
    ["*"] = false,
  },
}

return options
