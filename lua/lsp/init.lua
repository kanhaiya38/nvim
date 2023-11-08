local M = {}

local setup_autocmds = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      require('keymaps').lsp(ev.buf)
    end,
  })
end

local get_default_capabilities = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

local default_on_attach = function(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local setup_servers = function()
  local lspconfig = require('lspconfig')
  local servers = require('settings').servers
  local installed_servers = require('mason-lspconfig').get_installed_servers()
  local default_capabilities = get_default_capabilities()

  for _, server in ipairs(installed_servers) do
    local server_config = servers[server]
    local server_opts = {
      capabilities = default_capabilities,
      on_attach = default_on_attach,
    }
    if server_config and server_config.custom_setup then
      require('lsp.servers.' .. server).setup(server_opts)
    else
      lspconfig[server].setup(server_opts)
    end
  end
end

M.setup = function()
  setup_servers()
  setup_autocmds()
end

return M
