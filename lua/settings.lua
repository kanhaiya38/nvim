local M = {}

M.ft = {
  neotree = 'neo-tree',
  neotree_popup = 'neo-tree-popup',
  help = 'help',
  mason = 'mason',
  lazy = 'lazy',
}

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
  tailwindcss = { disabled = true },
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
  o.signcolumn = 'yes:1'
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

local json_to_jsonc = function()
  vim.cmd([[autocmd BufRead,BufNewFile *.json set filetype=jsonc]])
end

local setup_diagnostics = function()
  local icons = require('icons')

  vim.diagnostic.config({
    virtual_text = { source = true, prefix = icons.misc.Dot },
    float = { source = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

  -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
  for type, icon in pairs(icons.diagnostic) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

M.setup = function()
  setup_variables()
  setup_diagnostics()
  json_to_jsonc()
end

return M
