local actions = require('telescope.actions')
local telescope = require('telescope')
local extensions= require('configs.telescope.extensions')

telescope.setup({
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
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      theme = 'dropdown',
      entry_maker = require('configs.telescope.entry_maker').find_files(),
    },
    buffers = {
      theme = 'dropdown',
    },
    live_grep = {
      theme = 'dropdown',
    },
  },
  extensions = extensions.config,
})

extensions.setup();
