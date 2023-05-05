---@type LazySpec
local plugins = {
  -- Setting up LSP
  {
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    dependencies = 'williamboman/mason-lspconfig.nvim',
    config = function()
      require('lsp').setup()
    end,
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'MasonUpdate',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = 'williamboman/mason.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = require('lsp.utils').get_ensure_installed(),
      })
    end,
  },
  {
    'tamago324/nlsp-settings.nvim',
    opts = {
      config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
      local_settings_dir = '.nlsp-settings',
      local_settings_root_markers = { '.git' },
      append_default_schemas = true,
      loader = 'json',
    },
  },

  { 'folke/neodev.nvim' },
  { 'simrat39/rust-tools.nvim' },
  { 'p00f/clangd_extensions.nvim' },
  { 'jose-elias-alvarez/typescript.nvim' },
  'b0o/schemastore.nvim', -- jsonls
}

return plugins
