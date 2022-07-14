local luasnip = require 'luasnip'
local vscode_loader = require 'luasnip/loaders/from_vscode'

vscode_loader.lazy_load {
  paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' },
}
vscode_loader.load { paths = { '~/dotfiles/snippets' } }

luasnip.filetype_extend('javascript', { 'javascriptreact' })
