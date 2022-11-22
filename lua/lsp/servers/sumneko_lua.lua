local M = {}

M.setup = function(server_opts)
  require('neodev').setup({})

  require('lspconfig')['sumneko_lua'].setup(server_opts)
end

return M
