-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-source-in-diagnostics

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, _, params, client_id, _)
  local config = { -- your config
    underline = true,
    virtual_text = {
      prefix = '■ ',
      spacing = 4,
    },
    signs = true,
    update_in_insert = false,
  }
  local uri = params.uri
  local bufnr = vim.uri_to_bufnr(uri)

  if not bufnr then
    return
  end

  local diagnostics = params.diagnostics

  for i, v in ipairs(diagnostics) do
    diagnostics[i].message = string.format('%s: %s', v.source, v.message)
  end

  vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end
