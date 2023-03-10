local keymaps = require('keymaps')

---@type LazySpec
local plugins = {
  {
    'folke/lazy.nvim',
    version = '*',
    init = keymaps.lazy,
  },

  {
    'glepnir/lspsaga.nvim',
    config = true,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = true,
    enabled = false,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },

  {
    'rcarriga/nvim-notify',
    init = keymaps.notify,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      text = {
        spinner = 'pipe', -- animation shown when tasks are ongoing
        done = '', -- character shown when all tasks are complete
        commenced = 'Started', -- message shown when task starts
        completed = 'Completed', -- message shown when task completes
      },
    },
  },

  {
    'kevinhwang91/nvim-ufo',
    init = keymaps.ufo,
    config = function()
      -- vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require('ufo').setup()
    end,
    dependencies = 'kevinhwang91/promise-async',
  },

  -- Surroundings
  {
    'kylechui/nvim-surround',
    lazy = false,
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    config = true,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'danymat/neogen',
    cmd = 'Neogen',
    config = true,
  },

  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

      require('auto-session').setup({
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        pre_save_cmds = { 'NeoTreeClose', 'DiffviewClose' },
      })
    end,
  },

  -- Which Key
  {
    'folke/which-key.nvim',
    keys = '<Space>',
    config = true,
  },

  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    opts = {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '>codechef', '>codeforces', '>atcoder' },
      ignore_lsp = { 'null-ls', 'html' },
      -- silent_chdir = false,
    },
  },
  {
    'michaelb/sniprun',
    cmd = 'SnipRun',
    build = 'bash ./install.sh',
  },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = { timeout = 200 },
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  -- Utils
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'famiu/bufdelete.nvim',
    cmd = 'Bdelete',
  },

  'nvim-lua/plenary.nvim',
  'kyazdani42/nvim-web-devicons',
}

return plugins
