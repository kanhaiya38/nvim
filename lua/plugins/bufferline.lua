local config = function()
  local bl = require('bufferline')
  local icons = require('icons')
  vim.cmd([[autocmd FileType qf set nobuflisted]])

  bl.setup({
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = level:match('error') and icons.diagnostic.Error or icons.diagnostic.Warning
        return ' ' .. icon .. count
      end,
      numbers = function(opts)
        return string.format('%s', opts.raise(opts.ordinal))
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
          separator = icons.misc.Separator,
          -- separator = true -- use a "true" to enable the default, or set your own character
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
}

return plugins
