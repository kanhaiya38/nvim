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
vim.o.shell = '/usr/bin/fish'
vim.g.mapleader = ' '

O = {}

O.kinds = {
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

O.servers = {
  'sumneko_lua',
  'rust_analyzer',
  'pyright',
  'clangd',
  'yamlls',
  'tsserver',
  'html',
  'jsonls',
  'cssls',
  'dockerls',
  'bashls',
}

-- glow
vim.g.glow_binary_path = '/usr/bin'

-- markdown preview
vim.g.mkdp_browser = 'qutebrowser'

-- startuptime
vim.g.startuptime_tries = 5

-- surround.nvim
vim.g.surround_mappings_style = 'surround'

-- dashboard
vim.g.dashboard_default_executive = 'telescope'

-- notify
_, vim.notify = pcall(require, 'notify')

-- disable builtin plugins
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
