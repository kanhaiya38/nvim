-- keymaps
local nnoremap = function(key, map)
  vim.api.nvim_set_keymap('n', key, map, { noremap = true, silent = true })
end

nnoremap('gb', '<Cmd>BufferLinePick<CR>')
-- nnoremap('[b', '<Cmd>BufferLineCycleNext<CR>')
-- nnoremap('b]', '<Cmd>BufferLineCyclePrev<CR>')
nnoremap('<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>')
nnoremap('<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>')
nnoremap('<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>')
nnoremap('<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>')
nnoremap('<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>')
nnoremap('<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>')
nnoremap('<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>')
nnoremap('<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>')
nnoremap('<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>')

require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match 'error' and O.kinds.lsp.error or O.kinds.lsp.warning
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
}
