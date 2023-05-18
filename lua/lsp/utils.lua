local M = {}

local get_default_capabilities = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

M.default_capabilities = get_default_capabilities()

M.default_on_attach = function(client, bufnr)
  require('keymaps').lsp(bufnr)

  -- Disable language server formatting
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

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

M.get_ensure_installed = function()
  local servers = require('settings').servers

  local ensure_installed = {}
  for key, _ in pairs(servers) do
    table.insert(ensure_installed, key)
  end
  return ensure_installed
end

M.get_installed_servers = require('mason-lspconfig').get_installed_servers

M.setup_diagnostics = function()
  local icons = require('icons')

  vim.diagnostic.config({
    virtual_text = { source = true, prefix = icons.misc.Dot },
    float = { source = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

  -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
  for type, icon in pairs(icons.diagnostic) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
