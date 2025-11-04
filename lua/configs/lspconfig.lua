require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local exepath = vim.fn.exepath

local servers = {
  html = {
    cmd = { exepath "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
  },
  cssls = {
    cmd = { exepath "vscode-css-language-server", "--stdio" },
  },
  ts_ls = {
    cmd = { exepath "typescript-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { upward = true })[1]),
  },
  graphql = {
    filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  },
  rust_analyzer = {
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
            vim.lsp.buf.format { async = false }
          end,
        })
      end
    end,
  },
  gopls = {
    cmd = { exepath "gopls" },
    settings = {
      gopls = {
        gofumpt = true,
        analyses = { unusedparams = true },
        staticcheck = true,
      },
    },
  },
}

if exepath "lua-language-server" ~= "" then
  servers.lua_ls = {
    cmd = { exepath "lua-language-server" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }
end

-- Sunucuları etkinleştir
for name, opts in pairs(servers) do
  opts.on_attach = opts.on_attach or nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities
  vim.lsp.config[name] = opts
end

vim.lsp.enable(vim.tbl_keys(servers))
