local M = {}

-- TODO: Check if it can be set up using nlsp-settings
M.setup = function(server_opts)
  server_opts.settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  }
  require('lspconfig').jsonls.setup(server_opts)
end

return M
