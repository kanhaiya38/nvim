local actions = require('telescope.actions')
local telescope = require('telescope')

local fzf = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}

local load_extensions = function()
  telescope.load_extension('fzf')
  telescope.load_extension('projects')
end

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
  extensions = {
    fzf = fzf,
  },
})

load_extensions()
