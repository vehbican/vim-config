---@type HLTable
local M = {}

M.override = {
  Normal = { bg = "none" },
  NormalNC = { bg = "none" },
  NormalFloat = { bg = "none" },
  FloatBorder = { bg = "none" },
  SignColumn = { bg = "none" },
  VertSplit = { bg = "none" },

  -- Add these lines for nvim-tree or neo-tree
  NvimTreeNormal = { bg = "none" },
  NvimTreeNormalNC = { bg = "none" },
  NvimTreeEndOfBuffer = { bg = "none" },
  NvimTreeVertSplit = { bg = "none" },
}

return M
