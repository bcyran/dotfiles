local options = {
  lsp_on_attach = require("plugins.configs.lspconfig").on_attach,
  lsp_cfg = {
    capabilities = require("plugins.configs.lspconfig").capabilities,
  },
  lsp_gofumpt = true,
  lsp_inlay_hints = {
    enable = true,
    show_parameter_hints = false,
  },
}

return options
