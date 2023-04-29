local options = {
  dev_log = {
    enabled = true,
    notify_errors = true,
    open_cmd = "tabedit",
  },
  widget_guides = {
    enabled = true,
  },
  lsp = {
    on_attach = require("plugins.configs.lspconfig").on_attach,
    capabilities = require("plugins.configs.lspconfig").capabilities,
    settings = {
      lineLength = 100,
    },
  },
}

return options
