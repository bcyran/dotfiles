vim.g.rustaceanvim = {
  tools = {
    inlay_hints = {
      auto = true,
      only_current_line = true,
    },
  },
  server = {
    on_attach = require("plugins.configs.lspconfig").on_attach,
    capabilities = require("plugins.configs.lspconfig").capabilities,
  },
}
