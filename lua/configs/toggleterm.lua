local M = {}

local setup_custom_terminals = function()
  local Terminal = require('toggleterm.terminal').Terminal

  M.lazygit = Terminal:new({
    cmd = 'lazygit',
    direction = 'float',
    hidden = true,
  })
end

M.setup = function()
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

  setup_custom_terminals()
end

return M
