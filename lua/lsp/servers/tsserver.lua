local M = {}

M.setup = function(server_opts)
  local on_attach = server_opts.on_attach
  server_opts.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require('keymaps').typescript(bufnr)
  end
  require('typescript').setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = server_opts, -- pass options to lspconfig's setup method
  })
end

return M
