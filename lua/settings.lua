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

vim.cmd [[ set runtimepath-=/usr/share/vim/vimfiles ]]

O = {}

O.kinds = {
  lsp = {
    hint = '',
    info = '',
    warning = '',
    error = '',
  },
}

local utils = require 'lsp.utils'

O.servers = {
  sumneko_lua = {
    enhance_opts = true,
  },
  rust_analyzer = {
    -- TODO: loader function is not set up in lsp
    loader = function(server)
      require('rust-tools').setup {
        -- The "server" property provided in rust-tools setup function are the
        -- settings rust-tools will provide to lspconfig during init.            --
        -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
        -- with the user's own settings (opts).
        server = vim.tbl_deep_extend('force', server:get_default_options(), utils.get_server_opts(server.name)),
      }
      server:attach_buffers()
      -- Only if standalone support is needed
      -- require('rust-tools').start_standalone_if_required()
    end,
  },
  clangd = {
    enhance_opts = true,
    loader = function(server)
      require('clangd_extensions').setup {
        server = utils.get_server_opts('clangd', true),
      }
      server:attach_buffers()
    end,
  },
  tsserver = {
    enhance_opts = true,
  },
  pyright = {},
  yamlls = {},
  eslint = {},
  html = {},
  jsonls = {},
  cssls = {},
  dockerls = {},
  bashls = {},
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
