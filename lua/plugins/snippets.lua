local config = function()
  require('luasnip.loaders.from_vscode').lazy_load()

  require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets' })

  require('luasnip').filetype_extend('typescript', { 'javascript' })
end

---@type LazySpec
local plugins = {
  {
    'L3MON4D3/Luasnip',
    build = 'make install_jsregexp',
    config = config,
    dependencies = 'rafamadriz/friendly-snippets',
  },
}

return plugins
