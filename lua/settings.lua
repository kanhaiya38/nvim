local M = {}

M.servers = {
  lua_ls = { custom_setup = true },
  rust_analyzer = { custom_setup = true },
  clangd = { custom_setup = true },
  tsserver = { custom_setup = true },
  pyright = {},
  yamlls = {},
  eslint = {},
  html = {},
  jsonls = { custom_setup = true },
  cssls = {},
  dockerls = {},
  bashls = {},
}

local setup_variables = function()
  local o = vim.o
  local cmd = vim.cmd
  local g = vim.g

  o.number = true
  o.relativenumber = true
  o.shiftwidth = 2
  o.tabstop = 2
  o.expandtab = true
  o.relativenumber = true
  o.encoding = 'UTF-8'
  o.updatetime = 100
  o.timeoutlen = 500
  o.undofile = true
  cmd('set clipboard+=unnamedplus')
  o.shell = '/usr/bin/fish'
  g.mapleader = ' '
  o.termguicolors = true

  cmd([[ set runtimepath-=/usr/share/vim/vimfiles ]])

  -- glow
  g.glow_binary_path = '/usr/bin'

  -- markdown preview
  g.mkdp_browser = 'qutebrowser'

  -- startuptime
  g.startuptime_tries = 5
end

local setup_notify = function()
  -- notify
  local ok, notify = pcall(require, 'notify')

  if ok then
    vim.notify = notify
  end
end

local disable_builtins = function()
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
end

local json_to_jsonc = function()
  vim.cmd([[autocmd BufRead,BufNewFile *.json set filetype=jsonc]])
end

M.setup = function()
  setup_variables()
  disable_builtins()
  setup_notify()
  json_to_jsonc()
end

return M
