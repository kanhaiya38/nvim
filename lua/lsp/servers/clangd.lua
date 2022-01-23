local M = {}

local capabilities = require('lsp.utils').default_capabilities()
capabilities.offsetEncoding = { 'utf-16' }

M.capabilities = capabilities

return M
