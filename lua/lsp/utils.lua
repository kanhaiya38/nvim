local M = {}

M.default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- enable snippet support
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

-- keymaps
local setup_keymaps = function(bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

M.default_on_attach = function(client, bufnr)
  setup_keymaps(bufnr)

  -- Disable language server formatting
  client.resolved_capabilities.document_formatting = false

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
M.diagnostics_symbols = function()
  local signs = {
    Error = O.kinds.lsp.error,
    Warning = O.kinds.lsp.warning,
    Hint = O.kinds.lsp.warning,
    Information = O.kinds.info,
  }

  for type, icon in pairs(signs) do
    local hl = 'LspDiagnosticsSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-source-in-diagnostics
M.show_source = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, result, context, config)
    local client_id = context.client_id
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = result.diagnostics

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    -- don't mutate the original diagnostic because it would interfere with
    -- code action (and probably other stuff, too)
    local prefixed_diagnostics = vim.deepcopy(diagnostics)
    for i, v in pairs(diagnostics) do
      prefixed_diagnostics[i].message = string.format('%s: %s', v.source, v.message)
    end
    vim.lsp.diagnostic.display(prefixed_diagnostics, bufnr, client_id, config)
  end
end
return M
