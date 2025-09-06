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
      require("configs.null-ls")
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer" }, 
      })
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local nvlsp = require("nvchad.configs.lspconfig")
      require("flutter-tools").setup({
        lsp = {
          on_attach = nvlsp.on_attach,
          capabilities = nvlsp.capabilities,
        },
        widget_guides = { enabled = true },
        closing_tags = { enabled = true, prefix = " // ", highlight = "Comment" },
        debugger = { enabled = true, run_via_dap = true }, 
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, "dart")
      end
    end,
  },
}
