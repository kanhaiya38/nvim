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
  formatting.clang_format.with {
    extra_args = { '-style=file', '--fallback-style=Google' },
  },

  -- markdown
  diagnostics.markdownlint,
  diagnostics.vale.with {
    extra_args = { '--config', vim.fn.expand '~/.config/vale/vale.ini' },
  },

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
