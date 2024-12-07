-- Load defaults for LSP
require("nvchad.configs.lspconfig").defaults()
require("configs.null-ls")

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- List of LSP servers to configure with default settings
local servers = { "html", "cssls" }

-- Setup each LSP server with default configuration
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configure Angular Language Server
lspconfig.angularls.setup {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/ngserver",
    "--stdio",
    "--tsProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
    "--ngProbeLocations",
    vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
  },
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }, -- Angular-specific filetypes
  root_dir = lspconfig.util.root_pattern("angular.json", ".git"), -- Root directory detection
  on_attach = nvlsp.on_attach, -- Custom attach function
  capabilities = nvlsp.capabilities, -- Custom capabilities for LSP
}

-- Configure TypeScript Language Server (using ts_ls instead of tsserver)
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
}

-- Configure GraphQL Language Server
lspconfig.graphql.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
}



-- Import null-ls
local null_ls = require("null-ls")

-- Configure null-ls
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css" },
    }),
  },
  on_attach = function(client, bufnr)
    -- Enable formatting on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})


lspconfig.dartls.setup {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_dir = lspconfig.util.root_pattern("pubspec.yaml", ".git"),
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr) -- Call NvChad's default on_attach

    -- Enable formatting on save
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


