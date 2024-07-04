-- ~/.config/nvim/lua/config/lsp.lua

-- Source LSP configurations
local lspconfig = require("lspconfig")
local lsp_common = require("config.lsp_common")

-- Example configuration for LSP servers
-- Replace 'pyright' with the LSP server you are using
lspconfig.pyright.setup({
  on_attach = lsp_common.on_attach,
})

-- LSP settings for Dart
lspconfig.dartls.setup({
  on_attach = lsp_common.on_attach,
  cmd = { "dart", "language-server", "--protocol=lsp" },
})

-- Add other LSP servers configurations as needed
