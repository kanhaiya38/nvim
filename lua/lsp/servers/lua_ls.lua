local M = {}

M.setup = function(server_opts)
  require('neodev').setup({})

  require('lspconfig')['lua_ls'].setup(server_opts)
end

return M
