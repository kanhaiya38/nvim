local utils = require 'lsp.utils'
local lsp_installer = require 'nvim-lsp-installer'

local function setup_servers()
  local enhanced_servers = { 'sumneko_lua', 'clangd', 'tsserver' }
  local enhance_server_opts = {}
  for _, name in ipairs(enhanced_servers) do
    enhance_server_opts[name] = require('lsp.servers.' .. name)
  end

  lsp_installer.on_server_ready(function(server)
    -- Specify the default options which we'll use to setup all servers
    local opts = {
      capabilities = utils.default_capabilities(),
      on_attach = utils.default_on_attach,
    }

    if enhance_server_opts[server.name] then
      -- Enhance the default opts with the server-specific ones
      enhance_server_opts[server.name](opts)
    end

    server:setup(opts)
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
