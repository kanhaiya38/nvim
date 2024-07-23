---@type LazySpec
local plugins = {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'black', 'isort' },
        sh = { 'shfmt' },
        fish = { 'fish_indent' },
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
        jsonc = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
      },
      log_level = vim.log.levels.DEBUG,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
    },
    lazy = false,
  },
}

return plugins
