require("nvim-tree").setup({
  view = {
    width = 50,
    side = "left",
    preserve_window_proportions = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    group_empty = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})

