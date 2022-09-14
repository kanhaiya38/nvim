local M = {}

M.setup = function()
  require('indent_blankline').setup({
    filetype_exclude = {
      'help',
      'mason',
      'packer',
    },
    buftype_exclude = { 'terminal' },
    char_list = { '|', '¦', '┆', '┊' },
    space_char_blankline = ' ',
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
  })
end

return M
