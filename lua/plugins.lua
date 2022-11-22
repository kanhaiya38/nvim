local M = {}

local bootstrap = function()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    execute('packadd packer.nvim')
  end
end

M.setup = function()
  local keymaps = require('keymaps')

  bootstrap()
  -- automatically run :PackerCompile whenever plugins.lua is updated
  vim.cmd([[autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source <afile> | PackerCompile]])

  require('packer').startup({
    function(use)
      -- Packer can manage itself
      use({ 'wbthomason/packer.nvim', setup = keymaps.packer })
      use('lewis6991/impatient.nvim')
      use('nathom/filetype.nvim')
      -- Setting up LSP
      use({
        'neovim/nvim-lspconfig',
        config = function()
          require('lsp').setup()
        end,
        requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
      })
      use({
        'tamago324/nlsp-settings.nvim',
        config = function()
          require('configs.nlspsettings').setup()
        end,
      })
      -- Formatting and Linting
      use({
        'jose-elias-alvarez/null-ls.nvim',
        setup = keymaps.null_ls,
        config = function()
          require('configs.null-ls').setup()
        end,
      })

      -- Autocompletion
      use({
        'hrsh7th/nvim-cmp',
        as = 'cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
          require('configs.cmp').setup()
        end,
      })
      use({ 'hrsh7th/cmp-buffer', after = 'cmp' })
      use({ 'hrsh7th/cmp-nvim-lsp', after = 'cmp' })
      use({ 'saadparwaiz1/cmp_luasnip', after = 'cmp' })
      use({ 'hrsh7th/cmp-path', after = 'cmp' })
      use({ 'hrsh7th/cmp-calc', after = 'cmp' })
      use({ 'hrsh7th/cmp-emoji', after = 'cmp' })
      use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'cmp' })
      use({ 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'cmp' })
      use({ 'hrsh7th/cmp-cmdline', after = 'cmp' })
      -- Snippets
      use({
        'L3MON4D3/Luasnip',
        config = function()
          require('configs.snippets').setup()
        end,
        after = 'cmp',
        requires = 'rafamadriz/friendly-snippets',
      })
      use({
        'onsails/lspkind-nvim',
        -- after = 'nvim-cmp',
        config = function()
          require('lspkind').init({})
        end,
      })

      use({
        'glepnir/lspsaga.nvim',
        config = function()
          local saga = require('lspsaga')
          saga.init_lsp_saga({
            code_action_lightbulb = {
              cache_code_action = false,
            },
          })
        end,
      })
      -- Surroundings
      use({
        'kylechui/nvim-surround',
        config = function()
          require('nvim-surround').setup()
        end,
      })
      use({
        'windwp/nvim-autopairs',
        -- event = 'InsertEnter',
        config = function()
          require('nvim-autopairs').setup({})
        end,
      })

      -- Telescope
      use({
        'nvim-telescope/telescope.nvim',
        module = { 'configs.telescope', 'telescope' },
        cmd = 'Telescope',
        setup = keymaps.telescope,
        config = function()
          require('configs.telescope').setup()
        end,
      })
      use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

      use({
        'folke/trouble.nvim',
        cmd = 'Trouble',
        config = function()
          require('trouble').setup({})
        end,
        disable = true,
      })
      use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
      -- Terminal
      use({
        'akinsho/nvim-toggleterm.lua',
        cmd = 'ToggleTerm',
        keys = '<C-Space>',
        module = { 'toggleterm', 'configs.toggleterm' },
        setup = keymaps.toggleterm,
        config = function()
          require('configs.toggleterm').setup()
        end,
      })

      -- Git
      use({ 'tpope/vim-fugitive' })
      use({
        'lewis6991/gitsigns.nvim',
        config = function()
          require('configs.gitsigns').setup()
        end,
      })

      -- Comments
      use({
        'numToStr/Comment.nvim',
        config = function()
          require('configs.comment').setup()
        end,
      })
      use({
        'danymat/neogen',
        config = function()
          require('neogen').setup({})
        end,
      })

      -- UI
      -- Colorschemes
      use({
        'navarasu/onedark.nvim',
        as = 'theme',
        config = function()
          require('configs.theme').setup()
        end,
      })
      -- Statusline and Bufferline
      use({
        'nvim-lualine/lualine.nvim',
        after = 'theme',
        config = function()
          require('configs.statusline').setup()
        end,
      })
      use({
        'akinsho/bufferline.nvim',
        after = 'theme',
        setup = keymaps.bufferline,
        config = function()
          require('configs.bufferline').setup()
        end,
      })
      use({
        'j-hui/fidget.nvim',
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
      })
      use({
        'lukas-reineke/indent-blankline.nvim',
        after = { 'theme', 'treesitter' },
        config = function()
          require('configs.indent').setup()
        end,
      })
      use({ 'rcarriga/nvim-notify', setup = keymaps.notify })
      use({
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        setup = keymaps.ufo,
        config = function()
          -- vim.o.foldcolumn = '1'
          vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
          vim.o.foldlevelstart = 99
          vim.o.foldenable = true
          require('ufo').setup()
        end,
      })

      -- Dashboard
      use({
        'startup-nvim/startup.nvim',
        after = 'theme',
        config = function()
          require('configs.dashboard')
        end,
        -- TODO: configure dashboard as it is breaking auto-session
        disable = true,
      })
      use({
        'rmagatti/auto-session',
        config = function()
          vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

          require('auto-session').setup({
            log_level = 'error',
            auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            pre_save_cmds = { 'NeoTreeClose' },
          })
        end,
      })

      -- Tree Explorer
      use({
        'kyazdani42/nvim-tree.lua',
        module = 'nvim-tree',
        setup = keymaps.nvim_tree,
        config = function()
          require('configs.nvim-tree').setup()
        end,
        disable = true,
      })
      use({
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        module = 'neo-tree',
        setup = keymaps.neo_tree,
        config = function()
          require('configs.tree').setup()
        end,
        requires = 'MunifTanjim/nui.nvim',
      })

      -- Which Key
      use({
        'folke/which-key.nvim',
        keys = '<Space>',
        config = function()
          require('configs.which-key').setup()
        end,
      })

      -- Treesitter
      use({
        'nvim-treesitter/nvim-treesitter',
        as = 'treesitter',
        event = 'BufEnter',
        config = function()
          require('configs.treesitter').setup()
        end,
        run = ':TSUpdate',
      })
      use({
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
        after = 'treesitter',
      })
      use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'treesitter' })
      use({ 'p00f/nvim-ts-rainbow', after = 'treesitter' })
      use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'treesitter' })
      use({
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup()
        end,
        after = 'treesitter',
      })

      use({
        'ahmedkhalf/project.nvim',
        config = function()
          require('configs.project').setup()
        end,
      })
      use({
        'NMAC427/guess-indent.nvim',
        setup = keymaps.guess_indent,
        config = function()
          require('guess-indent').setup({})
        end,
      })
      use({
        'max397574/better-escape.nvim',
        event = 'InsertEnter',
        config = function()
          require('better_escape').setup({ timeout = 200 })
        end,
      })
      use({ 'michaelb/sniprun', cmd = 'SnipRun', run = 'bash ./install.sh' })
      use('dstein64/vim-startuptime')

      -- Language Specific
      use({ 'npxbr/glow.nvim', cmd = 'Glow' })
      use({ 'folke/neodev.nvim' })
      use({ 'simrat39/rust-tools.nvim' })
      use({ 'p00f/clangd_extensions.nvim' })
      use({ 'jose-elias-alvarez/typescript.nvim' })
      use({
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = 'markdown',
      })
      use({
        'nvim-neorg/neorg',
        ft = 'norg',
        config = function()
          require('configs.neorg').setup()
        end,
      })

      -- Utils
      use('nvim-lua/plenary.nvim')
      use('kyazdani42/nvim-web-devicons')
      use('b0o/schemastore.nvim')
      use({
        'norcalli/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup()
        end,
      })
      use('famiu/bufdelete.nvim')
      use({
        'ekickx/clipboard-image.nvim',
        config = function()
          require('clipboard-image').setup({})
        end,
      })
    end,
    config = {
      -- Move to lua dir so impatient.nvim can cache it
      -- compile_path = vim.fn.stdpath 'config' .. '/lua/packer_compiled.lua',
    },
  })
end

return M
