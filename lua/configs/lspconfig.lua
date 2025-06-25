-- Load NvChad LSP defaults and null-ls setup
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local null_ls = require("null-ls")

-- LSP servers basic setup
local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Angular LSP
lspconfig.angularls.setup {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/ngserver",
    "--stdio",
    "--tsProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
    "--ngProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
  },
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_dir = lspconfig.util.root_pattern("angular.json", ".git"),
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

-- TypeScript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
}

-- GraphQL
lspconfig.graphql.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
}

-- Dart
lspconfig.dartls.setup {
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
}

-- Rust
lspconfig.rust_analyzer.setup {
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
}

-- null-ls + Prettier setup with htmlangular support
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "htmlangular", -- ✨ kritik eklenti!
        "css",
      },
    }),
  },
  on_attach = function(client, bufnr)
    if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
      vim.api.nvim_create_augroup("LspFormatting", { clear = false })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LspFormatting",
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            async = false,
            bufnr = bufnr,
            filter = function(format_client)
              return format_client.name == "null-ls"
            end,
          })
        end,
      })
    end
  end,
})
