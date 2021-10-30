local actions = require 'telescope.actions'
local telescope = require 'telescope'

local M = {}

M.setup = function()
  telescope.setup {
    defaults = {
      layout_config = {
        horizontal = { height = 0.75, width = 0.7, preview_width = 0.57 },
      },
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
      },
    },
  }

  telescope.load_extension 'projects'
end

return M
