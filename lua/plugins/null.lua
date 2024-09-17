local config = function()
  local null = require('null-ls')
  local diagnostics = null.builtins.diagnostics

  local sources = {
    -- lua
    diagnostics.selene,

    -- js

    -- python
    diagnostics.flake8,

    -- c/c++
    -- markdown
    diagnostics.markdownlint,
    diagnostics.vale.with({
      extra_args = { '--config', vim.fn.expand('~/.config/vale/vale.ini') },
    }),

    -- shell scripts
    diagnostics.fish,
  }

  null.setup({
    debug = false,
    sources = sources,
  })
end

---@type LazySpec
local plugins = {
  {
    'nvimtools/none-ls.nvim',
    keys = require('keymaps').null_ls,
    event = 'BufRead',
    config = config,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        automatic_installation = true,
      })
    end,
  },
}

return plugins
