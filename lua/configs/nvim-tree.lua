local M = {}

M.setup = function()
  local g = vim.g
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  local list = {
    { key = { 'l' }, cb = tree_cb 'edit' },
    { key = { '<CR>' }, cb = tree_cb 'cd' },
    { key = 'v', cb = tree_cb 'vsplit' },
    { key = 's', cb = tree_cb 'split' },
    { key = 't', cb = tree_cb 'tabnew' },
    { key = 'o', cb = tree_cb 'system_open' },
    { key = '<', cb = tree_cb 'prev_sibling' },
    { key = '>', cb = tree_cb 'next_sibling' },
    { key = 'P', cb = tree_cb 'parent_node' },
    { key = 'h', cb = tree_cb 'close_node' },
    { key = '<S-CR>', cb = tree_cb 'close_node' },
    { key = '<Tab>', cb = tree_cb 'preview' },
    { key = 'K', cb = tree_cb 'first_sibling' },
    { key = 'J', cb = tree_cb 'last_sibling' },
    { key = 'I', cb = tree_cb 'toggle_ignored' },
    { key = 'H', cb = tree_cb 'toggle_dotfiles' },
    { key = 'R', cb = tree_cb 'refresh' },
    { key = 'a', cb = tree_cb 'create' },
    { key = 'd', cb = tree_cb 'remove' },
    { key = 'r', cb = tree_cb 'rename' },
    { key = '<C-r>', cb = tree_cb 'full_rename' },
    { key = 'x', cb = tree_cb 'cut' },
    { key = 'c', cb = tree_cb 'copy' },
    { key = 'p', cb = tree_cb 'paste' },
    { key = 'y', cb = tree_cb 'copy_name' },
    { key = 'Y', cb = tree_cb 'copy_path' },
    { key = 'gy', cb = tree_cb 'copy_absolute_path' },
    { key = '[c', cb = tree_cb 'prev_git_item' },
    { key = ']c', cb = tree_cb 'next_git_item' },
    { key = '<BS>', cb = tree_cb 'dir_up' },
    { key = 'q', cb = tree_cb 'close' },
    { key = 'g?', cb = tree_cb 'toggle_help' },
  }
  g.nvim_tree_auto_ignore_ft = { 'dashboard' }
  g.nvim_tree_git_hl = 1
  g.nvim_tree_highlight_opened_files = 1
  g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
  g.nvim_tree_group_empty = 1
  g.nvim_tree_disable_window_picker = 0 -- 0 by default, will disable the window picker.
  g.nvim_tree_icon_padding = ' '
  g.nvim_tree_respect_buf_cwd = 1
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

  require('nvim-tree').setup {
    open_on_setup = true,
    auto_close = true,
    tab_open = true,
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = true },
    lsp_diagnostics = true,
    view = {
      mappings = {
        custom_only = true,
        list = list,
      },
    },
  }
end

return M
