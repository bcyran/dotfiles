return {
  {
    "stevearc/conform.nvim",
    opts = {
      lsp_fallback = true,

      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
  },
}
