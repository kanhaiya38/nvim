local capabilities = require('lsp.utils').get_default_capabilities()
capabilities.offsetEncoding = { 'utf-16' }

return function (opts)
  opts.capabilities = capabilities
end
