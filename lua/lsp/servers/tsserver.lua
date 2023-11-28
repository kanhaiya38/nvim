local M = {}

M.setup = function(server_opts)
  local on_attach = server_opts.on_attach
  server_opts.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require('keymaps').typescript(bufnr)
  end

  require('typescript-tools').setup(server_opts)
end

return M
