---@type LazySpec
local plugins = {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    opts = {
      filetype_exclude = {
        'help',
        'mason',
        'lazy',
        'neo-tree',
        'neo-tree-popup',
      },
      buftype_exclude = { 'terminal' },
      space_char_blankline = ' ',
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
  {
    'NMAC427/guess-indent.nvim',
    init = require('keymaps').guess_indent,
    config = true,
  },
}

return plugins
