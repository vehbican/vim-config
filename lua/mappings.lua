require "nvchad.mappings"


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.api.nvim_set_keymap('n', '<C-c>', 'gg"+yG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-a>', 'ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Left>", "v<Left>e", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Right>", "v<Right>e", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "F", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })

map("n", "<leader>vs", function()

  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber")
  vim.cmd("vertical resize 60")
  vim.cmd("wincmd h")
end, { desc = "Vertical split with terminal on the right" })

