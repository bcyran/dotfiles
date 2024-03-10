return {
  {
    "stevearc/conform.nvim",
    custom_keys = {
      { "<leader>fm", desc = "format buffer" },
    },
    opts = {
      lsp_fallback = true,

      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        sh = { "shfmt", "shellcheck" },
        python = { "black", "isort" },
        rust = { "rustfmt" },
        dart = { "dart_format" },
        go = { "golines" },
      },

      formatters = {
        black = {
          inherit = true,
          prepend_args = {
            "--line-length",
            "100",
          },
        },
        isort = {
          inherit = true,
          prepend_args = {
            "--profile",
            "black",
            "--line-length",
            "100",
            "--lines-after-imports",
            "2",
            "--combine-as",
          },
        },
        shfmt = {
          inherit = true,
          prepend_args = {
            "--indent",
            "4",
            "--binary-next-line",
            "--case-indent",
            "--space-redirects",
          },
        },
        shellcheck = {
          inherit = true,
          prepend_args = {
            "--enable=avoid-nullary-conditions,require-variable-braces,require-double-brackets",
            "--exclude=SC1091",
          },
        },
        dart_format = {
          inherit = true,
          args = {
            "format",
            "--line-length",
            "100",
          },
        },
        golines = {
          inherit = true,
          prepend_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
          },
        },
      },
    },
  },
}
