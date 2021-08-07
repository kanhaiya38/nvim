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
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  -- Autocompletion
  use 'hrsh7th/nvim-compe'
  use {
    'ray-x/lsp_signature.nvim',
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

  -- Terminal
  use 'akinsho/nvim-toggleterm.lua'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
      }
    end,
  }

  -- Statusline and Bufferline
  use 'glepnir/galaxyline.nvim'
  use 'romgrk/barbar.nvim'

  -- Which Key
  use {
    'folke/which-key.nvim',
    config = function()
      require 'plugins.configs.which-key'
    end,
  }

  -- Snippets
  use 'L3MON4D3/Luasnip'
  use 'rafamadriz/friendly-snippets'

  -- Comments
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  }

  -- Formatter
  use 'mhartington/formatter.nvim'

  -- Linter
  use {
    'mfussenegger/nvim-lint',
    config = function()
      require 'plugins.configs.linter'
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

  -- Colorschemes
  use 'navarasu/onedark.nvim'

  -- Tree Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.configs.nvim-tree').setup()
    end,
  }

  -- Dashboard
  use 'glepnir/dashboard-nvim'

  -- Indent
  use 'lukas-reineke/indent-blankline.nvim'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Utils
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use { 'jdhao/better-escape.vim', event = 'InsertEnter' }
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'ahmedkhalf/lsp-rooter.nvim',
    config = function()
      require('lsp-rooter').setup {}
    end,
  }
  use 'tjdevries/astronauta.nvim'
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

  -- Language Specific
  use { 'npxbr/glow.nvim', run = 'GlowInstall' }
  use 'simrat39/rust-tools.nvim'
end)
