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

  -- Snippets
  use 'L3MON4D3/Luasnip'
  use 'rafamadriz/friendly-snippets'
  
  -- Colorschemes
  use 'navarasu/onedark.nvim'
end)

