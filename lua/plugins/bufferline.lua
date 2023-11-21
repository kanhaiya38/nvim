local config = function()
  local bl = require('bufferline')
  local icons = require('icons')
  local settings = require('settings')
  vim.cmd([[autocmd FileType qf set nobuflisted]])

  bl.setup({
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = level:match('error') and icons.diagnostic.Error or icons.diagnostic.Warn
        return ' ' .. icon .. count
      end,
      numbers = function(opts)
        return string.format('%s', opts.raise(opts.ordinal))
      end,
      offsets = {
        {
          filetype = settings.ft.neotree,
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  })
end

---@type LazySpec
local plugins = {
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    init = require('keymaps').bufferline,
    config = config,
  },
  {
    'axkirillov/hbac.nvim',
    lazy = false,
    opts = {
      threshold = 7,
    },
  },
}

return plugins
