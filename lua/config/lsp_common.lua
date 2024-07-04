-- ~/.config/nvim/lua/config/lsp_common.lua

local M = {}

M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<space>wl",
    "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>q", "<Cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.documentRangeFormattingProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end

return M
