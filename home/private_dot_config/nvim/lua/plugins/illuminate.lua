local function goto_next_reference()
  require("illuminate").goto_next_reference(true)
end

local function goto_prev_reference()
  require("illuminate").goto_prev_reference(true)
end

return {
  {
    "RRethy/vim-illuminate",
    lazy = false,
    init = function()
      require("illuminate").configure({
        filetypes_denylist = {
          "gitcommit",
          "NvimTree",
          "help",
          "sagafinder",
          "sagaoutline",
        },
        min_count_to_highlight = 2,
      })
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
    keys = {
      { "en", goto_next_reference, { desc = "Next reference" } },
      { "ep", goto_prev_reference, { desc = "Prev reference" } },
    },
  },
}
