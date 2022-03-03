require('indent_blankline').setup {
  filetype_exclude = {
    'help',
    'terminal',
    'dashboard',
    'startup',
  },
  buftype_exclude = { 'terminal' },
  char_list = { '|', '¦', '┆', '┊' },
  space_char_blankline = ' ',
  show_first_indent_level = false,
  show_current_context = true,
}
