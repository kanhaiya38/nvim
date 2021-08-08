require('null-ls').config {
  sources = {
    require('null-ls').builtins.formatting.stylua,
    require('null-ls').builtins.formatting.prettier,
  },
}
require('lspconfig')['null-ls'].setup {}
