-- stylua: ignore
local colors = {
  black        = '#13151a', -- '#181a1f',
  bg0          = '#1e222a', -- '#282c34',
  bg1          = '#1a1d24', -- '#31353f',
  bg2          = '#2c313b', -- '#393f4a',
  bg3          = '#3b3f4c', -- ,
  bg_d         = '#191d22', -- '#21252b',
  bg_statusline= '#191d22',
  bg_blue      = '#64a9e2', -- '#73b8f1',
  bg_yellow    = '#ebd09c',
  fg           = '#abb2bf',
  purple       = '#c678dd',
  green        = '#98c379',
  orange       = '#d19a66',
  blue         = '#61afef',
  yellow       = '#e5c07b',
  cyan         = '#56b6c2',
  red          = '#e86671',
  grey         = '#5c6370',
  light_grey   = '#7c8492',
  dark_cyan    = '#2b6f77',
  dark_red     = '#993939',
  dark_yellow  = '#93691d',
  dark_purple  = '#8a3fa0',
  diff_add     = '#31392b',
  diff_delete  = '#382b2c',
  diff_change  = '#1c3448',
  diff_text    = '#2c5372',
}

local highlights = {
  SagaNormal = { bg = '$bg0' },
}

local config = function()
  local theme = require('onedark')

  theme.setup({
    colors = colors,
    highlights = highlights,
    diagnostics = {
      darker = false,
    },
  })
  theme.load()
end

---@type LazySpec
local plugins = {
  {
    'navarasu/onedark.nvim',
    name = 'theme',
    lazy = false,
    priority = 1000,
    config = config,
  },
}

return plugins
