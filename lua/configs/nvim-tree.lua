local M = {}

local get_mappings = function()
  local tree_cb = require('nvim-tree.config').nvim_tree_callback

  -- TODO: migrate to `on_attach` function as setting mappings in setup is soon going to be deprecated
  return {
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
end

M.setup = function()
  require('nvim-tree').setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    renderer = {
      highlight_opened_files = 'name',
      icons = {
        git_placement = 'after',
      },
    },
    view = {
      mappings = { list = get_mappings() },
    },
  })
end

return M
