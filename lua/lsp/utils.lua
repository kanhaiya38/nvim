local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local wk = require 'which-key'
local M = {}

local get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return cmp_nvim_lsp.update_capabilities(capabilities)
end

M.default_capabilities = get_default_capabilities()

-- keymaps
local setup_keymaps = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local lsp_opts = { mode = 'n', noremap = true, silent = true, buffer = bufnr }
  local lsp_mappings = {
    ['gD'] = { vim.lsp.buf.declaration, 'declaration' },
    ['gd'] = { vim.lsp.buf.definition, 'definition' },
    ['K'] = { vim.lsp.buf.hover, 'hover' },
    ['gI'] = { vim.lsp.buf.implementation, 'implementation' },
    ['gh'] = { vim.lsp.buf.signature_help, 'signature_help' },
    ['<space>wa'] = { vim.lsp.buf.add_workspace_folder, 'add workspace' },
    ['<space>wr'] = { vim.lsp.buf.remove_workspace_folder, 'remove workspace' },
    ['<space>wl'] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      'list workspace',
    },
    ['<space>D'] = { vim.lsp.buf.type_definition, 'type definition' },
    ['<space>rn'] = { vim.lsp.buf.rename, 'rename' },
    ['<space>ca'] = { vim.lsp.buf.code_action, 'code action' },
    ['gR'] = { vim.lsp.buf.references, 'references' },
    ['<space>f'] = { vim.lsp.buf.formatting, 'format' },
  }
  wk.register(lsp_mappings, lsp_opts)

  local diagnostic_opts = { mode = 'n', noremap = true, silent = true }
  local diagnostic_mappings = {
    ['<space>e'] = { vim.diagnostic.open_float, 'open diagnostic' },
    ['[d'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
    [']d'] = { vim.diagnostic.goto_next, 'next diagnostic' },
    ['<space>q'] = { vim.diagnostic.setloclist, 'setloclist' },
  }
  wk.register(diagnostic_mappings, diagnostic_opts)
end

M.default_on_attach = function(client, bufnr)
  setup_keymaps(bufnr)

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

M.default_server_opts = { capabilities = M.default_capabilities, on_attach = M.default_on_attach }

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
M.diagnostics_symbols = function()
  local signs = {
    Error = O.kinds.lsp.error,
    Warning = O.kinds.lsp.warning,
    Hint = O.kinds.lsp.warning,
    Information = O.kinds.info,
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end
end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-source-in-diagnostics
M.show_source = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      source = 'always', -- Or "if_many"
    },
  })
end
return M
