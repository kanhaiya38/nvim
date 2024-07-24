---@type LazySpec
local plugins = {
  {
    'petertriho/nvim-scrollbar',
    lazy = false,
    config = function()
      local settings = require('settings')
      local colors = require('onedark.colors')
      local Dash = ' -'
      local Dot = '󰨓 '

      require('scrollbar').setup({
        handle = {
          text = '  ',
          blend = 20,
          color = colors.bg2,
        },
        marks = {
          Cursor = { text = Dot, color = colors.blue },
          Error = { text = { Dot, '󰨓󰨓' } },
          Warn = { text = { Dot, '󰨓󰨓' } },
          Info = { text = { Dot, '󰨓󰨓' } },
          Hint = { text = { Dot, '󰨓󰨓' } },
          GitAdd = { text = Dash },
          GitDelete = { text = Dash },
          GitChange = { text = Dash, color = colors.yellow },
        },
        excluded_filetypes = {
          settings.ft.lazy,
          settings.ft.mason,
          settings.ft.neotree,
          settings.ft.neotree_popup,
          settings.ft.noice,
          settings.ft.ssr,
        },
      })
    end,
  },
}

return plugins
