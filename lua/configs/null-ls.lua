local M = {}

M.setup = function()
  local null = require('null-ls')
  local formatting = null.builtins.formatting
  local diagnostics = null.builtins.diagnostics

  local sources = {
    -- lua
    formatting.stylua,
    diagnostics.selene,

    -- js
    formatting.prettierd,

    -- python
    formatting.black,
    diagnostics.flake8,
    formatting.isort,

    -- c/c++
    formatting.clang_format.with({
      extra_args = { '-style=file', '--fallback-style=Google' },
    }),

    -- markdown
    diagnostics.markdownlint,
    diagnostics.vale.with({
      extra_args = { '--config', vim.fn.expand('~/.config/vale/vale.ini') },
    }),

    -- shell scripts
    formatting.shfmt,
    diagnostics.shellcheck,
    diagnostics.fish,
    formatting.fish_indent,

    -- rust
    -- formatting.rustfmt, // use rust-tools
  }

  null.setup({
    debug = false,
    sources = sources,
  })
end

return M
