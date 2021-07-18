local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  execute 'packadd packer.nvim'
end

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Setting up LSP
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  -- Autocompletion
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'

  -- Terminal
  use 'akinsho/nvim-toggleterm.lua'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
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
end)
