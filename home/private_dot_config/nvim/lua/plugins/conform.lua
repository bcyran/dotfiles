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
        dart = { "dart_format" },
      },

      formatters = {
        dart_format = {
          inherit = true,
          args = {
            "format",
            "--line-length",
            "100",
          },
        },
      },
    },
  },
}
