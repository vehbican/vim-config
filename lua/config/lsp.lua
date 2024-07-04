-- ~/.config/nvim/lua/config/lsp.lua

-- Source LSP configurations
local lspconfig = require("lspconfig")
local lsp_common = require("config.lsp_common")

-- LSP settings for Dart
lspconfig.dartls.setup({
  on_attach = lsp_common.on_attach,
  cmd = { "dart", "language-server", "--protocol=lsp" },
})

-- LSP settings for TypeScript and JavaScript
lspconfig.tsserver.setup({
  on_attach = lsp_common.on_attach,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

-- LSP settings for Angular
lspconfig.angularls.setup({
  on_attach = lsp_common.on_attach,
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
    "--ngProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
  },
  root_dir = lspconfig.util.root_pattern("angular.json", ".git"),
  capabilities = lsp_common.capabilities,
})
