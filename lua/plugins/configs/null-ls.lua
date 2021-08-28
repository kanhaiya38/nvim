local formatting = require 'null-ls.builtins.formatting'
local code_actions = require 'null-ls.builtins.code-actions'
local diagnostics = require 'null-ls.builtins.diagnostics'

local sources = {
  -- lua
  formatting.stylua,
  diagnostics.luacheck,

  -- js
  formatting.prettier,

  -- python
  formatting.black,
  diagnostics.flake8,
  formatting.isort,

  -- c/c++
  formatting.clang_format,

  -- markdown
  diagnostics.markdownlint,

  -- shell scripts
  formatting.shfmt,
  diagnostics.shellcheck,
  formatting.fish_indent,

  -- rust
  formatting.rustfmt,

  -- git
  code_actions.gitsigns,
}
require('null-ls').config { sources = sources }
require('lspconfig')['null-ls'].setup {}
