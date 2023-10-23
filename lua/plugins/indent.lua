---@type LazySpec
local plugins = {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    lazy = false,
    config = true,
  },
  {
    'NMAC427/guess-indent.nvim',
    lazy = false,
    keys = require('keymaps').guess_indent,
    config = true,
  },
}

return plugins
