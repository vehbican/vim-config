local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "html", "htmlangular",
        "css",
      },
    }),
    formatting.google_java_format, 
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
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
