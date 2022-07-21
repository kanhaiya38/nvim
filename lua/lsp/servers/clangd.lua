local M = {}

M.setup = function(server_opts)
  server_opts.capabilities.offsetEncoding = { 'utf-16' }

  require('clangd_extensions').setup({
    server = server_opts,
  })
end

return M
