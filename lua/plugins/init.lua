return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },


{
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls") 

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css" },
        }),
      },
      on_attach = function(client, bufnr)
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
  end,
},

  -- Lazygit Plugin

{
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })
  end,
},

}
