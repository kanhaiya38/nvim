local keymaps = require('keymaps')

---@type LazySpec
local plugins = {
  {
    'folke/lazy.nvim',
    version = '*',
    init = keymaps.lazy,
  },
  {
    'utilyre/barbecue.nvim',
    lazy = false,
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = true,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    config = true,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    keys = keymaps.lspsaga,
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    enabled = false,
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
    event = 'VeryLazy',
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    config = true,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    keys = { 'gcc', 'gcj', 'gck', { 'gc', mode = 'v' } },
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

  -- Utils
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    keys = keymaps.refactoring,
    config = function()
      require('refactoring').setup({
        print_var_statements = {
          typescriptreact = { "console.log('%s', %s)" },
          typescript = { "console.log('%s', %s)" },
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    enabled = false,
    keys = {
      { '<Leader>l', '<Cmd>noh<CR>' },
      { '*', [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#', [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
    },
    config = function()
      -- require('hlslens').setup() is not required
      require('scrollbar.handlers.search').setup({
        -- hlslens config overrides
      })
    end,
  },
  {
    'famiu/bufdelete.nvim',
    cmd = 'Bdelete',
  },

  'nvim-lua/plenary.nvim',
}

return plugins
