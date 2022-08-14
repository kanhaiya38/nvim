require('toggleterm').setup({
  open_mapping = [[<C-Space>]],
  direction = 'vertical',
  persist_size = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
})

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  direction = 'float',
  hidden = true,
})

return { lazygit = lazygit }
