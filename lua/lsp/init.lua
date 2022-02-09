local utils = require 'lsp.utils'
local lsp_installer = require 'nvim-lsp-installer'

local function setup_servers()
  local enhance_server_opts = {
    -- Provide settings that should only apply to a specific server
    ['sumneko_lua'] = function(opts)
      opts.settings = require('lsp.servers.sumneko_lua').settings
    end,
    ['clangd'] = function(opts)
      opts.capabilities = require('lsp.servers.clangd').capabilities
    end,
    ['tsserver'] = function(opts)
      opts.init_options = require('lsp.servers.tsserver').init_options
      opts.on_attach = require('lsp.servers.tsserver').on_attach
    end,
  }
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
