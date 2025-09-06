local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "html", "css",
      },
    }),

    formatting.dart_format,
  },

  on_attach = function(client, bufnr)
    if client.name ~= "null-ls" or not client.supports_method("textDocument/formatting") then
      return
    end
    local grp = vim.api.nvim_create_augroup("NullLsFormat", { clear = false })
    vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          filter = function(c) return c.name == "null-ls" end,
        })
      end,
    })
  end,
})
