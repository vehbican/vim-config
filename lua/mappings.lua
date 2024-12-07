require "nvchad.mappings"

-- Add your custom mappings here

local map = vim.keymap.set

-- Pre-existing mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.api.nvim_set_keymap('n', '<C-c>', 'gg"+yG', { noremap = true, silent = true }) -- Copy entire file
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })   -- Select entire file in normal mode
vim.api.nvim_set_keymap('v', '<C-a>', 'ggVG', { noremap = true, silent = true })   -- Select entire file in visual mode
vim.api.nvim_set_keymap("n", "<C-S-Left>", "v<Left>e", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Right>", "v<Right>e", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "F", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })

-- New mapping for vertical split with terminal
--
map("n", "<leader>vs", function()

  vim.cmd("vsplit")                  -- Create a vertical split
  vim.cmd("wincmd l")                -- Focus the right split
  vim.cmd("terminal")                -- Open a terminal in the right split
  vim.cmd("setlocal nonumber norelativenumber") -- Disable line numbers for terminal
  vim.cmd("vertical resize 60")      -- Resize the terminal window
  vim.cmd("wincmd h")                -- Return focus to the left split
end, { desc = "Vertical split with terminal on the right" })

