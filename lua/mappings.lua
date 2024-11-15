require "nvchad.mappings"

-- Add your custom mappings here

local map = vim.keymap.set

-- Pre-existing mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Add new key mappings
vim.api.nvim_set_keymap('n', '<C-c>', 'gg"+yG', { noremap = true, silent = true }) -- Copy entire file
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })   -- Select entire file in normal mode
vim.api.nvim_set_keymap('v', '<C-a>', 'ggVG', { noremap = true, silent = true })   -- Select entire file in visual mode

