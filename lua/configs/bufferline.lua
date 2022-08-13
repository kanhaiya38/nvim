local bl = require('bufferline')

bl.setup({
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and O.kinds.lsp.error or O.kinds.lsp.warning
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
