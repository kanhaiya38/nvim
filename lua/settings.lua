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

-- colorscheme
require('onedark').setup()

-- snippets
require('luasnip/loaders/from_vscode').lazy_load {
  paths = { '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' },
}
