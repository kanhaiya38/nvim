local M = {}

local get_default_capabilities = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities({})

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
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
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
    virtual_text = { source = true, prefix = icons.misc.Square },
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
