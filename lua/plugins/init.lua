local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Setting up LSP
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  -- Autocompletion
  use 'hrsh7th/nvim-compe'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'

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

  -- Snippets
  use 'L3MON4D3/Luasnip'
  use 'rafamadriz/friendly-snippets'

  -- Surroundings
  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require('surround').setup {}
    end,
  }
  use 'windwp/nvim-autopairs'
 
  -- Colorschemes
  use 'navarasu/onedark.nvim'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Utils
  use 'nvim-lua/popup.nvim' 
  use 'nvim-lua/plenary.nvim'
end)

