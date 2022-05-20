vim.o.hidden = true -- otherwise terminal will be discarded when closed

local M = {}
M.terminals = {}

M.setup = function()
  require('toggleterm').setup {
    open_mapping = [[<C-Space>]],
    shade_terminals = true,
    shading_factor = 0.6,
    direction = 'vertical',
    persist_size = false,
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
  }
  local Terminal = require('toggleterm.terminal').Terminal
  M.terminals.lazygit = Terminal:new {
    cmd = 'lazygit',
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
      width = 120,
      height = 33,
      highlights = {
        border = 'TelescopeBorder',
        background = 'TelescopeNormal',
      },
    },
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(
        term.bufnr,
        'i',
        '<C-c>',
        '<cmd>require("configs.toggleterm").toggle("lazygit")<CR>',
        { noremap = true, silent = true }
      )
    end,
  }
end

M.toggle = function(terminal)
  M.terminals[terminal]:toggle()
end

M.exec = function(cmd)
  require('toggleterm.terminal').Terminal
    :new({
      cmd = cmd,
      close_on_exit = false,
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = 120,
        height = 33,
        highlights = {
          border = 'TelescopeBorder',
          background = 'TelescopeNormal',
        },
      },
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      end,
    })
    :toggle()
end

return M
