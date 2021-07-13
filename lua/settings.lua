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

-- autopairs
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
}

-- surround.nvim
vim.g.surround_mappings_style = 'surround'

-- dashboard
vim.g.dashboard_default_executive = 'telescope'
