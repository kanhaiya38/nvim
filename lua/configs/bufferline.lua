local utils = require('utils')
local bl = require('bufferline')

local go_to_buffer = function(num)
  return function()
    bl.go_to_buffer(num, true)
  end
end

local cycle = function(num)
  return function()
    bl.cycle(num)
  end
end

utils.set_keymaps({
  -- Go to buffer
  ['[b'] = { cycle(-1), 'prev buffer' },
  [']b'] = { cycle(1), 'next buffer' },
  ['<leader>1'] = { go_to_buffer(1), 'go to buffer 1' },
  ['<leader>2'] = { go_to_buffer(2), 'go to buffer 2' },
  ['<leader>3'] = { go_to_buffer(3), 'go to buffer 3' },
  ['<leader>4'] = { go_to_buffer(4), 'go to buffer 4' },
  ['<leader>5'] = { go_to_buffer(5), 'go to buffer 5' },
  ['<leader>6'] = { go_to_buffer(6), 'go to buffer 6' },
  ['<leader>7'] = { go_to_buffer(7), 'go to buffer 7' },
  ['<leader>8'] = { go_to_buffer(8), 'go to buffer 8' },
  ['<leader>9'] = { go_to_buffer(9), 'go to buffer 9' },
  ['<leader>0'] = { go_to_buffer(-1), 'go to buffer 0' },
}, { silent = true, noremap = true })

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
