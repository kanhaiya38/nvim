local M = {}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = string.format('lazygit -ucf %s/lazygit.yml', vim.fn.stdpath('config')),
  direction = 'float',
  count = 98,
})

M.exec = Terminal:new({
  direction = 'vertical',
  count = 99,
})

M.lazygit = function()
  lazygit:toggle()
end

return M
