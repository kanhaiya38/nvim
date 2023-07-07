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
    config = true,
    keys = require('keymaps').paste_img,
  },
}

return plugins
