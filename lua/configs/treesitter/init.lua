local extensions = require('configs.treesitter.extensions')
-- for neorg
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

parser_configs.norg_table = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

require('nvim-treesitter.configs').setup({
  auto_install = true,
  ignore_install = {}, -- List of parsers to ignore installing
  -- default
  highlight = extensions.highlight,
  incremental_selection = extensions.incremental_selection,
  -- plugins
  context_commentstring = extensions.context_commentstring,
  rainbow = extensions.rainbow,
  textobjects = extensions.textobjects,
})
