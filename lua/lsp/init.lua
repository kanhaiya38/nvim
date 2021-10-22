local utils = require 'lsp.utils'

-- config that activates keymaps and enables snippet support
local function make_config(server)
  local default_config = {
    capabilities = require('lsp.utils').default_capabilities(),
    settings = nil,
    on_attach = require('lsp.utils').default_on_attach,
  }

  if server == nil then
    server = default_config
  end
  if server.capabilities == nil then
    server.capabilities = default_config.capabilities
  end
  if server.settings == nil then
    server.settings = default_config.settings
  end
  if server.on_attach == nil then
    server.on_attach = default_config.on_attach
  end

  return server
end

-- lsp-install
local function setup_servers()
  require('lspinstall').setup()

  -- get all installed servers
  local servers = require('lspinstall').installed_servers()
  -- add manually installed servers
  table.insert(servers, 'clangd')

  local server_configs = {}
  server_configs.lua = require 'lsp.servers.lua'
  server_configs.typescript = require 'lsp.servers.typescript'

  for _, server in pairs(servers) do
    local config = make_config(server_configs[server])
    require('lspconfig')[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd 'bufdo e'
end

utils.show_source()
utils.diagnostics_symbols()
