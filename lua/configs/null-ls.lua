local M = {}

M.setup = function()
  local null = require('null-ls')
  local formatting = null.builtins.formatting
  -- local code_actions = null.builtins.code_actions
  local diagnostics = null.builtins.diagnostics
  local command_resolver = require('null-ls.helpers.command_resolver')

  local sources = {
    -- lua
    formatting.stylua,
    diagnostics.selene,

    -- js
    -- formatting.prettier,
    formatting.prettierd,
    -- formatting.prettier.with({
    --   dynamic_command = command_resolver.from_node_modules(),
    -- }),

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
    formatting.fish_indent,

    -- rust
    -- formatting.rustfmt, // use rust-tools

    -- git
    -- code_actions.gitsigns,
  }

  null.setup({
    debug = false,
    sources = sources,
  })
end

return M
