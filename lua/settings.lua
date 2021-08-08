vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.encoding = 'UTF-8'
vim.o.updatetime = 100
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.cmd 'set clipboard+=unnamedplus'

vim.g.mapleader = ' '

-- colorscheme
require('onedark').setup()

O.kinds = {
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

-- surround.nvim
vim.g.surround_mappings_style = 'surround'

-- dashboard
vim.g.dashboard_default_executive = 'telescope'

-- indent-blankline
vim.g.indent_blankline_filetype_exclude = {
  'help',
  'terminal',
  'dashboard',
}
vim.g.indent_blankline_buftype_exclude = { 'terminal' }
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_char_list = { '|', '¦', '┆', '┊' }
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
