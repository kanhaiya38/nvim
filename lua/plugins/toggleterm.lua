local config = function()
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
end

---@type LazySpec
local plugins = {
  {
    'akinsho/nvim-toggleterm.lua',
    cmd = 'ToggleTerm',
    keys = require('keymaps').toggleterm,
    config = config,
  },
}

return plugins
