-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local null_ls = require "null-ls"

-- yardımcı: exepath ile binary bul
local exepath = vim.fn.exepath

-- HTML
lspconfig.html.setup {
  cmd = { exepath("vscode-html-language-server"), "--stdio" },
  filetypes = { "html" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

-- CSS
lspconfig.cssls.setup {
  cmd = { exepath("vscode-css-language-server"), "--stdio" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}

-- TypeScript (lspconfig'de adı artık ts_ls)
lspconfig.ts_ls.setup {
  cmd = { exepath("typescript-language-server"), "--stdio" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
}

-- GraphQL (sende binary yoksa sabit cmd yazma, PATH'te ise kendisi bulur)
lspconfig.graphql.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
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
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end
  end,
}

-- null-ls + Prettier
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript","javascriptreact","typescript","typescriptreact",
        "html","htmlangular","css",
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
            filter = function(c) return c.name == "null-ls" end,
          })
        end,
      })
    end
  end,
})
