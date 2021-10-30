local utils = require 'lsp.utils'
local lsp_installer = require 'nvim-lsp-installer'
local lsp_installer_servers = require 'nvim-lsp-installer.servers'

-- config that activates keymaps and enables snippet support
local function make_config(server)
  local default_capabilities = utils.default_capabilities()
  local default_on_attach = utils.default_on_attach

  local config = {}
  if server == 'tsserver' then
    config = require 'lsp.servers.typescript'
  elseif server == 'sumneko_lua' then
    config = require 'lsp.servers.lua'
  end

  return {
    capabilities = config.capabilities or default_capabilities,
    settings = config.settings,
    on_attach = config.on_attach or default_on_attach,
  }
end

local function setup_servers()
  lsp_installer.on_server_ready(function(server)
    local config = make_config(server.name)
    server:setup(config)
    vim.cmd [[ do User LspAttachBuffers ]]
  end)
end

local function install_servers()
  for _, server in ipairs(O.servers) do
    local ok, server_analyzer = lsp_installer_servers.get_server(server)
    if ok then
      if not server_analyzer:is_installed() then
        -- server_analyzer:install(server) -- will install in background
        lsp_installer.install(server) -- install window will popup
      end
    end
  end
end

local M = {}

M.setup = function()
  install_servers()
  setup_servers()
  utils.show_source()
  utils.diagnostics_symbols()
end

return M
