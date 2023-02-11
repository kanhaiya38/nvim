local M = {}

local bootstrap = function()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

M.setup = function()
  local keymaps = require('keymaps')

  bootstrap()

  require('lazy').setup({
    'lewis6991/impatient.nvim',
    { 'folke/lazy.nvim', version = '*', init = keymaps.lazy },
    -- Setting up LSP
    {
      'neovim/nvim-lspconfig',
      event = 'BufRead',
      config = function()
        require('lsp').setup()
      end,
      dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    },
    {
      'tamago324/nlsp-settings.nvim',
      config = function()
        require('configs.nlspsettings').setup()
      end,
    },
    -- Formatting and Linting
    {
      'jose-elias-alvarez/null-ls.nvim',
      init = keymaps.null_ls,
      event = 'BufRead',
      config = function()
        require('configs.null-ls').setup()
      end,
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      name = 'cmp',
      event = { 'InsertEnter', 'CmdlineEnter' },
      config = function()
        require('configs.cmp').setup()
      end,
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-cmdline',
      },
    },
    -- Snippets
    {
      'L3MON4D3/Luasnip',
      config = function()
        require('configs.snippets').setup()
      end,
      dependencies = 'rafamadriz/friendly-snippets',
    },
    {
      'onsails/lspkind-nvim',
      config = function()
        require('lspkind').init({})
      end,
    },

    {
      'glepnir/lspsaga.nvim',
      config = function()
        require('lspsaga').setup({})
      end,
    },
    -- Surroundings
    {
      'kylechui/nvim-surround',
      lazy = false,
      config = function()
        require('nvim-surround').setup()
      end,
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({})
      end,
    },

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      init = keymaps.telescope,
      config = function()
        require('configs.telescope').setup()
      end,
      dependencies = {
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
      },
    },

    {
      'folke/trouble.nvim',
      cmd = 'Trouble',
      config = function()
        require('trouble').setup({})
      end,
      enabled = false,
    },
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    -- Terminal
    {
      'akinsho/nvim-toggleterm.lua',
      cmd = 'ToggleTerm',
      keys = '<C-Space>',
      init = keymaps.toggleterm,
      config = function()
        require('configs.toggleterm').setup()
      end,
    },

    -- Git
    {
      'sindrets/diffview.nvim',
      config = function()
        require('configs.diffview').setup()
      end,
    },
    { 'tpope/vim-fugitive' },
    {
      'lewis6991/gitsigns.nvim',
      event = 'BufWinEnter',
      config = function()
        require('configs.gitsigns').setup()
      end,
    },

    -- Comments
    {
      'numToStr/Comment.nvim',
      lazy = false,
      config = function()
        require('configs.comment').setup()
      end,
    },
    {
      'danymat/neogen',
      config = function()
        require('neogen').setup({})
      end,
    },

    -- UI
    -- Colorschemes
    {
      'navarasu/onedark.nvim',
      name = 'theme',
      lazy = false,
      priority = 1000,
      config = function()
        require('configs.theme').setup()
      end,
    },
    -- Statusline and Bufferline
    {
      'nvim-lualine/lualine.nvim',
      lazy = false,
      config = function()
        require('configs.statusline').setup()
      end,
    },
    {
      'akinsho/bufferline.nvim',
      lazy = false,
      init = keymaps.bufferline,
      config = function()
        require('configs.bufferline').setup()
      end,
    },
    {
      'j-hui/fidget.nvim',
      event = 'VeryLazy',
      config = function()
        require('fidget').setup({
          text = {
            spinner = 'pipe', -- animation shown when tasks are ongoing
            done = '', -- character shown when all tasks are complete
            commenced = 'Started', -- message shown when task starts
            completed = 'Completed', -- message shown when task completes
          },
        })
      end,
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      event = 'VeryLazy',
      config = function()
        require('configs.indent').setup()
      end,
    },
    { 'rcarriga/nvim-notify', init = keymaps.notify },
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

    -- Dashboard
    {
      'startup-nvim/startup.nvim',
      config = function()
        require('configs.dashboard')
      end,
      -- TODO: configure dashboard as it is breaking auto-session
      enabled = false,
    },
    {
      'rmagatti/auto-session',
      lazy = false,
      config = function()
        vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

        require('auto-session').setup({
          log_level = 'error',
          auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
          pre_save_cmds = { 'NeoTreeClose' },
        })
      end,
    },

    -- Tree Explorer
    {
      'kyazdani42/nvim-tree.lua',
      init = keymaps.nvim_tree,
      config = function()
        require('configs.nvim-tree').setup()
      end,
      enabled = false,
    },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      init = keymaps.neo_tree,
      config = function()
        require('configs.tree').setup()
      end,
      dependencies = 'MunifTanjim/nui.nvim',
    },

    -- Which Key
    {
      'folke/which-key.nvim',
      keys = '<Space>',
      config = function()
        require('configs.which-key').setup()
      end,
    },

    -- Treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      name = 'treesitter',
      event = 'BufRead',
      config = function()
        require('configs.treesitter').setup()
      end,
      build = ':TSUpdate',
      dependencies = {
        {
          'windwp/nvim-ts-autotag',
          config = function()
            require('nvim-ts-autotag').setup()
          end,
        },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'p00f/nvim-ts-rainbow' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        {
          'nvim-treesitter/nvim-treesitter-context',
          config = function()
            require('treesitter-context').setup()
          end,
        },
      },
    },
    {
      'ahmedkhalf/project.nvim',
      config = function()
        require('configs.project').setup()
      end,
    },
    {
      'NMAC427/guess-indent.nvim',
      init = keymaps.guess_indent,
      config = function()
        require('guess-indent').setup({})
      end,
    },
    {
      'max397574/better-escape.nvim',
      event = 'InsertEnter',
      config = function()
        require('better_escape').setup({ timeout = 200 })
      end,
    },
    { 'michaelb/sniprun', cmd = 'SnipRun', build = 'bash ./install.sh' },
    { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

    -- Language Specific
    { 'npxbr/glow.nvim', cmd = 'Glow' },
    { 'folke/neodev.nvim' },
    { 'simrat39/rust-tools.nvim' },
    { 'p00f/clangd_extensions.nvim' },
    { 'jose-elias-alvarez/typescript.nvim' },
    {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && yarn install',
      ft = 'markdown',
    },
    {
      'nvim-neorg/neorg',
      ft = 'norg',
      config = function()
        require('configs.neorg').setup()
      end,
    },

    -- Utils
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'b0o/schemastore.nvim',
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end,
    },
    { 'famiu/bufdelete.nvim', cmd = 'Bdelete' },
    {
      'ekickx/clipboard-image.nvim',
      config = function()
        require('clipboard-image').setup({})
      end,
    },
  }, { defaults = { lazy = true } })
end

return M
