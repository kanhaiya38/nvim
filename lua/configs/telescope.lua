local actions = require('telescope.actions')
local themes = require('telescope.themes')
local telescope = require('telescope')

local fzf = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}

telescope.setup({
  defaults = themes.get_dropdown({
    layout_config = {
      horizontal = { height = 0.75, width = 0.7, preview_width = 0.57 },
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  }),
  extensions = {
    fzf = fzf,
  },
})

telescope.load_extension('fzf')
telescope.load_extension('projects')

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

return M
