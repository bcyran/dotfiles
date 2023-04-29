local options = {
  tools = {
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = false,
    },
  },
  server = {
    on_attach = require("plugins.configs.lspconfig").on_attach,
    capabilities = require("plugins.configs.lspconfig").capabilities,
  },
}

return options
