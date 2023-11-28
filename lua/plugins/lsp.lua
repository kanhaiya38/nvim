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
      local ensure_installed = {}
      local servers = require('settings').servers
      for key, _ in pairs(servers) do
        table.insert(ensure_installed, key)
      end
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
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
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  },
  'b0o/schemastore.nvim', -- jsonls
}

return plugins
