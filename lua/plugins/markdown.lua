---@type LazySpec
local plugins = {
  {
    'npxbr/glow.nvim',
    cmd = 'Glow',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
  {
    'ekickx/clipboard-image.nvim',
    cmd = 'PasteImg',
    config = true,
  },
}

return plugins
