local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  execute 'packadd packer.nvim'
end

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd [[autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerCompile]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Setting up LSP
  use 'kabouzeid/nvim-lspinstall'
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lsp'
    end,
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-compe',
    event = 'InsertEnter',
    config = function()
      require 'plugins.configs.compe'
    end,
    requires = 'Luasnip',
  }
  -- Snippets
  use {
    'L3MON4D3/Luasnip',
    event = 'InsertEnter',
    config = function()
      require 'plugins.configs.snippets'
    end,
    requires = 'rafamadriz/friendly-snippets',
  }
  use {
    'onsails/lspkind-nvim',
    after = 'nvim-compe',
    config = function()
      require('lspkind').init {}
    end,
  }
  use {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    config = function()
      require('lsp_signature').setup()
    end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'plugins.configs.telescope'
    end,
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }
  -- Terminal
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('plugins.configs.toggleterm').setup()
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
      }
    end,
  }

  -- Colorschemes
  use {
    'navarasu/onedark.nvim',
    as = 'theme',
    config = function()
      require('onedark').setup()
    end,
  }
  -- Statusline and Bufferline
  use {
    'glepnir/galaxyline.nvim',
    after = 'theme',
    config = function()
      require 'plugins.configs.statusline'
    end,
  }
  use {
    'akinsho/bufferline.nvim',
    after = 'theme',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  }
  -- use {
  --   'romgrk/barbar.nvim',
  --   after = 'theme',
  --   config = function()
  --     require 'plugins.configs.barbar'
  --   end,
  -- }
  -- Indent
  use { 'lukas-reineke/indent-blankline.nvim', after = 'theme' }

  -- Which Key
  use {
    'folke/which-key.nvim',
    config = function()
      require 'plugins.configs.which-key'
    end,
  }

  -- Comments
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  }

  -- Formatting and Linting
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'plugins.configs.null-ls'
    end,
  }

  -- Surroundings
  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require('surround').setup {}
    end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'plugins.configs.autopairs'
    end,
  }

  -- Tree Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.configs.nvim-tree').setup()
    end,
  }

  -- Dashboard
  use 'glepnir/dashboard-nvim'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Utils
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'plugins.configs.treesitter'
    end,
    run = ':TSUpdate',
  }
  use { 'michaelb/sniprun', run = 'bash ./install.sh' }
  use { 'jdhao/better-escape.vim', event = 'InsertEnter' }
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'ahmedkhalf/lsp-rooter.nvim',
    config = function()
      require('lsp-rooter').setup {}
    end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      fn['mkdp#util#install']()
    end,
    cmd = 'MarkdownPreview',
  }
  use {
    'vhyrro/neorg',
    config = function()
      require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ['core.defaults'] = {}, -- Load all the default modules
          ['core.norg.concealer'] = {}, -- Allows for use of icons
          ['core.norg.dirman'] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = '~/neorg',
              },
            },
          },
        },
      }
    end,
  }
  use 'dstein64/vim-startuptime'

  -- Language Specific
  use { 'npxbr/glow.nvim', run = 'GlowInstall' }
  use 'simrat39/rust-tools.nvim'
end)
