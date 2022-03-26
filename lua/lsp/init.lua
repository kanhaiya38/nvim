local utils = require 'lsp.utils'
local lsp_installer = require 'nvim-lsp-installer'

local function setup_servers()
  lsp_installer.on_server_ready(function(server)
    local server_config = O.servers[server.name] or {}
    if server_config.loader then
      -- print('Loading manual ' .. server.name)
      server_config.loader(server)
    else
      -- print('Loading default ' .. server.name)
      server:setup(utils.get_server_opts(server.name, server_config.enhance_opts))
    end
  end)
end

local function install_servers()
  for _, name in pairs(O.servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print('Installing ' .. name)
      server:install()
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
