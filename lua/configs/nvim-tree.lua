local tree_cb = require('nvim-tree.config').nvim_tree_callback

-- TODO: migrate to `on_attach` function as setting mappings in setup is soon going to be deprecated
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
  view = {
    mappings = { list = list },
  },
})
