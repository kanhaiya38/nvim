local M = {}

M.setup = function()
  require('diffview').setup({
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
    file_panel = {
      win_config = {
        width = 30,
      },
    },
  })
end

return M
