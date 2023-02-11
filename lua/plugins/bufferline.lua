local config = function()
  local bl = require('bufferline')
  local kinds = require('settings').kinds.lsp

  bl.setup({
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = level:match('error') and kinds.error or kinds.warning
        return ' ' .. icon .. ' ' .. count
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
          separator = '▊',
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
