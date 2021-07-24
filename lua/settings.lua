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

-- snippets
require('luasnip/loaders/from_vscode').lazy_load {
  paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' },
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

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.cmd [[ au TextChanged <buffer> lua require('lint').try_lint() ]]
