local M = {}

M.setup = function()
  local bl = require('bufferline')
  local kinds = require('settings').kinds.lsp

  bl.setup({
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match('error') and kinds.error or kinds.warning
        return ' ' .. icon .. ' ' .. count
      end,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  })
end

return M
