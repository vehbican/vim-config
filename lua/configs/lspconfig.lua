-- Load NvChad LSP defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- HTML LSP
lspconfig.html.setup({
  cmd = { "/home/can/.nvm/versions/node/v16.20.2/bin/vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
})

-- CSS LSP
lspconfig.cssls.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
})

-- TypeScript
lspconfig.ts_ls.setup({
  cmd = { "/home/can/.nvm/versions/node/v16.20.2/bin/typescript-language-server", "--stdio" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

-- GraphQL
lspconfig.graphql.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
})

-- Dart
lspconfig.dartls.setup({
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_dir = lspconfig.util.root_pattern("pubspec.yaml", ".git"),
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
  capabilities = nvlsp.capabilities,
})

-- Java (Spring Boot)
lspconfig.jdtls.setup({
  cmd = { "jdtls" },
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Otomatik formatlama null-ls tarafından yapılacak
  end,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle"),
})

-- Rust
lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
