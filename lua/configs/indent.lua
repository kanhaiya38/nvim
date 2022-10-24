local M = {}

M.setup = function()
  require('indent_blankline').setup({
    filetype_exclude = {
      'help',
      'mason',
      'packer',
      'neo-tree',
    },
    buftype_exclude = { 'terminal' },
    space_char_blankline = ' ',
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
  })
end

return M
