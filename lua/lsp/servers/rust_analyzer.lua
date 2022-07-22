local M = {}

M.setup = function(server_opts)
  require('rust-tools').setup({
    server = server_opts,
  })
end

return M
