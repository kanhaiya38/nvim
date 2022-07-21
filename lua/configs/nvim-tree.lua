local M = {}

M.setup = function()
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  local list = {
    { key = { 'l' }, cb = tree_cb('edit') },
    { key = { '<CR>' }, cb = tree_cb('cd') },
    { key = 'v', cb = tree_cb('vsplit') },
    { key = 's', cb = tree_cb('split') },
    { key = 't', cb = tree_cb('tabnew') },
    { key = 'o', cb = tree_cb('system_open') },
    { key = 'h', cb = tree_cb('close_node') },
    { key = '<BS>', cb = tree_cb('dir_up') },
    { key = '/', cb = tree_cb('live_filter') },
  }

  require('nvim-tree').setup({
    open_on_setup = true,
    update_focused_file = { enable = true },
    diagnostics = { enable = true, show_on_dirs = true },
    view = {
      mappings = { list = list },
    },
    renderer = {
      highlight_opened_files = 'name',
      -- indent_markers = {
      --   enable = true,
      --   icons = { corner = '└ ', edge = '│ ', item = '├ ', none = '- ' },
      -- },
      icons = {
        git_placement = 'after',
      },
    },
  })
end

return M
