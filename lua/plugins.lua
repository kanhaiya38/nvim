local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute('packadd packer.nvim')
end

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source <afile> | PackerCompile]])

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    use('lewis6991/impatient.nvim')
    use('nathom/filetype.nvim')
    -- Setting up LSP
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('lsp')
      end,
      requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    })
    use({
      'tamago324/nlsp-settings.nvim',
      config = function()
        require('configs.nlspsettings')
      end,
    })
    -- Formatting and Linting
    use({
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require('configs.null-ls')
      end,
    })

    -- Autocompletion
    use({
      'hrsh7th/nvim-cmp',
      as = 'cmp',
      event = { 'InsertEnter', 'CmdlineEnter' },
      config = function()
        require('configs.cmp')
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
        require('configs.snippets')
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
      'ray-x/lsp_signature.nvim',
      config = function()
        require('lsp_signature').setup()
      end,
      disable = true,
    })
    use({
      'glepnir/lspsaga.nvim',
      config = function()
        local saga = require('lspsaga')

        saga.init_lsp_saga({
          -- your configuration
        })
      end,
    })
    -- Surroundings
    use({ 'tpope/vim-surround' })
    use({ 'tpope/vim-repeat' })
    use({
      'windwp/nvim-autopairs',
      -- event = 'InsertEnter',
      config = function()
        require('configs.autopairs')
      end,
    })

    -- Telescope
    use({
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      config = function()
        require('configs.telescope')
      end,
    })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

    use({
      'folke/trouble.nvim',
      cmd = 'Trouble',
      requires = 'kyazdani42/nvim-web-devicons',
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
      config = function()
        require('configs.toggleterm').setup()
      end,
    })

    use({
      'beauwilliams/focus.nvim',
      config = function()
        require('focus').setup({ excluded_filetypes = { 'toggleterm' } })
      end,
      disable = true,
    })

    -- Git
    use({ 'tpope/vim-fugitive' })
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('configs.gitsigns')
      end,
    })

    -- Comments
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('configs.comment')
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
        require('configs.theme')
      end,
    })
    -- Statusline and Bufferline
    use({
      'nvim-lualine/lualine.nvim',
      after = 'theme',
      config = function()
        require('configs.statusline')
      end,
    })
    use({
      'akinsho/bufferline.nvim',
      after = 'theme',
      setup = function()
        require('keymaps').bufferline()
      end,
      config = function()
        require('configs.bufferline')
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
      after = 'theme',
      config = function()
        require('configs.indent')
      end,
    })
    use('rcarriga/nvim-notify')

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
        })
      end,
    })

    -- Tree Explorer
    use({
      'kyazdani42/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      config = function()
        require('configs.nvim-tree')
      end,
    })

    -- Which Key
    use({
      'folke/which-key.nvim',
      config = function()
        require('configs.which-key')
      end,
    })

    -- Treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('configs.treesitter')
      end,
      run = ':TSUpdate',
    })
    use({
      'windwp/nvim-ts-autotag',
      config = function()
        require('nvim-ts-autotag').setup()
      end,
      after = 'nvim-treesitter',
    })
    use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })
    use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
    use({
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup()
      end,
      after = 'nvim-treesitter',
    })

    use({
      'ahmedkhalf/project.nvim',
      config = function()
        require('configs.project')
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
    use({ 'simrat39/rust-tools.nvim' })
    use({ 'p00f/clangd_extensions.nvim' })
    use({ 'jose-elias-alvarez/typescript.nvim' })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
    })
    use({
      'vhyrro/neorg',
      ft = 'norg',
      after = 'nvim-treesitter', -- You may want to specify Telescope here as well
      config = function()
        require('configs.neorg')
      end,
    })

    -- Utils
    use('nvim-lua/plenary.nvim')
    use('kyazdani42/nvim-web-devicons')
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
