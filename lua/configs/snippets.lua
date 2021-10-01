require('luasnip/loaders/from_vscode').lazy_load {
  paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' },
}

-- local ls = require 'luasnip'
--
-- local cpp = {}
-- for key, val in pairs(require 'snippets.cpp') do
--   table.insert(cpp, ls.parser.parse_snippet(key, val))
-- end
--
-- require('luasnip').snippets = {
--   cpp = cpp,
-- }
require('luasnip/loaders/from_vscode').load { paths = { '~/dotfiles/snippets' } }
