---@type LazySpec
local plugins = {
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    config = function()
      require('indent_blankline').setup({
        filetype_exclude = require('settings').ft,
        buftype_exclude = { 'terminal' },
        space_char_blankline = ' ',
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  {
    'NMAC427/guess-indent.nvim',
    lazy = false,
    keys = require('keymaps').guess_indent,
    config = true,
  },
}

return plugins
