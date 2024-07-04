-- ~/.config/nvim/lua/config/theme.lua

-- Load the Catppuccin theme
require("catppuccin").setup({
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  term_colors = true,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = { "italic" },
    keywords = {},
    strings = {},
    variables = { "bold" },
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    lsp_trouble = false,
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = false,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = true,
    vim_sneak = true,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = true,
    ts_rainbow = true,
    hop = true,
    notify = true,
    telekasten = true,
    symbols_outline = true,
    mini = true,
  },
})

vim.cmd.colorscheme("catppuccin")
