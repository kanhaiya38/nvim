local M = {}

M.setup = function()
  local g = vim.g
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  g.nvim_tree_bindings = {
    { key = 'l', cb = tree_cb 'edit' },
    { key = 'h', cb = tree_cb 'close_node' },
    { key = 's', cb = tree_cb 'split' },
    { key = 'v', cb = tree_cb 'vsplit' },
    { key = 't', cb = tree_cb 'tabnew' },
  }
  g.nvim_tree_auto_open = 1
  g.nvim_tree_auto_close = 1
  g.nvim_tree_auto_ignore_ft = { 'dashboard' }
  g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
  g.nvim_tree_git_hl = 1
  g.nvim_tree_highlight_opened_files = 1
  g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
  g.nvim_tree_tab_open = 1
  g.nvim_tree_group_empty = 1
  g.nvim_tree_lsp_diagnostics = 1
  g.nvim_tree_disable_window_picker = 0 -- 0 by default, will disable the window picker.
  g.nvim_tree_icon_padding = ' '
  g.nvim_tree_update_cwd = 1 -- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
  g.nvim_tree_window_picker_exclude = {
    filetype = {
      'packer',
    },
    buftype = {
      'terminal',
    },
  }
  --  Dictionary of buffer option names mapped to a list of option values that
  --  indicates to the window picker that the buffer's window should not be
  --  selectable.
  -- g.nvim_tree_special_files = { README.md = 1, Makefile= 1, MAKEFILE= 1 } --  List of filenames that gets highlighted with NvimTreeSpecialFile
  g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  }

  g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = '✗',
      staged = '✓',
      unmerged = '',
      renamed = '➜',
      untracked = '★',
      deleted = '',
      ignored = '◌',
    },
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
    lsp = O.kinds.lsp,
  }
end

M.toggle = function()
  local view = require 'nvim-tree.view'
  if view.win_open() then
    require('nvim-tree').close()
    require('bufferline.state').set_offset(0)
  else
    require('bufferline.state').set_offset(31, 'EXPLORER')
    require('nvim-tree').find_file(true)
  end
end

return M
