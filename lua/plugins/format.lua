---@type LazySpec
local plugins = {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>af',
        function()
          require('conform').format({ async = true })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        python = { 'black', 'isort' },
        sh = { 'shfmt' },
        fish = { 'fish_indent' },
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'markdownlint', 'prettierd', 'prettier', stop_after_first = true },
      },
      log_level = vim.log.levels.DEBUG,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Conform will notify you when no formatters are available for the buffer
      notify_no_formatters = true,
    },
    lazy = false,
  },
}

return plugins
