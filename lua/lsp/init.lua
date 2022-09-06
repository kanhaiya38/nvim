local lspconfig = require('lspconfig')
local utils = require('lsp.utils')

local function setup_servers()
  for _, server in ipairs(utils.get_installed_servers()) do
    local default_server_config = { custom_setup = false }
    local server_config = O.servers[server] or default_server_config
    local server_opts = utils.default_server_opts
    if server_config.custom_setup then
      require('lsp.servers.' .. server).setup(server_opts)
    else
      lspconfig[server].setup(server_opts)
    end
  end
end

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = utils.get_ensure_installed(),
})
setup_servers()
utils.setup_diagnostics()
