local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    graphql = { "prettier" },
    rust = { "rustfmt" },
    lua = { "stylua" },
    go = { "goimports" },
  },

  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    local allow = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
      html = true,
      css = true,
      graphql = true,
      rust = true,
      lua = true,
      go = true,
    }

    if not allow[ft] then
      return
    end

    return { timeout_ms = 2000, lsp_fallback = true }
  end,

  notify_on_error = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format { bufnr = args.buf, async = false, lsp_fallback = true }
  end,
})
