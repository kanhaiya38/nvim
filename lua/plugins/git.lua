local diffview = {
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
}

local gitsigns = {
  current_line_blame = true,
  on_attach = require('keymaps').gitsigns,
  yadm = { enable = true },
}

---@type LazySpec
local plugins = {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
  },
  {
    'sindrets/diffview.nvim',
    init = require('keymaps').diffview,
    opts = diffview,
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufWinEnter',
    opts = gitsigns,
    config = function(self, opts)
      require('gitsigns').setup(opts)
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}

return plugins
