local extensions = require('configs.treesitter.extensions')

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
