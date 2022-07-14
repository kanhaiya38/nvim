local utils = require 'lsp.utils'
local lsp_installer = require 'nvim-lsp-installer'
local lspconfig = require 'lspconfig'

local function setup_servers()
  for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local server_config = O.servers[server.name]
    local server_opts = utils.get_server_opts(server.name, server_config.enhance_opts)
    if server_config.custom_setup then
      require('lsp.servers.' .. server.name).setup(server_opts)
    end
    lspconfig[server.name].setup(server_opts)
  end
end

local function install_servers()
  local ensure_installed = {}
  for key, _ in pairs(O.servers) do
    table.insert(ensure_installed, key)
  end
  lsp_installer.setup {
    ensure_installed = ensure_installed,
    automatic_installation = true,
  }
end

local M = {}

M.setup = function()
  install_servers()
  setup_servers()
  utils.show_source()
  utils.diagnostics_symbols()
end

return M
