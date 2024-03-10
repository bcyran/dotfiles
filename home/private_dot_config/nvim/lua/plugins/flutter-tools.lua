return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      dev_log = {
        enabled = true,
        notify_errors = true,
        open_cmd = "tabedit",
      },
      widget_guides = {
        enabled = true,
      },
      lsp = {
        settings = {
          lineLength = 100,
        },
      },
    },
  },
}
