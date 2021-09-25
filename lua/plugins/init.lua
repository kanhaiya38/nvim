local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  execute 'packadd packer.nvim'
end

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd [[autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerCompile]]

return require('packer').startup {
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    -- Setting up LSP
    use 'kabouzeid/nvim-lspinstall'
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require 'lsp'
      end,
    }
    -- Formatting and Linting
    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = function()
        require 'plugins.configs.null-ls'
      end,
    }

    -- Autocompletion
    use {
      'hrsh7th/nvim-cmp',
      -- event = 'InsertEnter',
      config = function()
        require 'plugins.configs.compe'
      end,
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
      },
    }
    -- Snippets
    use {
      'L3MON4D3/Luasnip',
      config = function()
        require 'plugins.configs.snippets'
      end,
      requires = 'rafamadriz/friendly-snippets',
    }
    use {
      'onsails/lspkind-nvim',
      after = 'nvim-cmp',
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
    -- Surroundings
    use { 'tpope/vim-surround' }
    use {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require 'plugins.configs.autopairs'
      end,
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      config = function()
        require 'plugins.configs.telescope'
      end,
    }

    use {
      'folke/trouble.nvim',
      cmd = 'Trouble',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup {}
      end,
    }
    -- Terminal
    use {
      'akinsho/nvim-toggleterm.lua',
      cmd = 'ToggleTerm',
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

    -- Comments
    use {
      'terrortylor/nvim-comment',
      config = function()
        require('nvim_comment').setup()
      end,
    }

    -- UI
    -- Colorschemes
    use {
      'ful1e5/onedark.nvim',
      as = 'theme',
      config = function()
        require('onedark').setup()
      end,
    }
    -- Statusline and Bufferline
    use {
      'hoob3rt/lualine.nvim',
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
    use {
      'lukas-reineke/indent-blankline.nvim',
      after = 'theme',
      config = function()
        require('indent_blankline').setup {
          filetype_exclude = {
            'help',
            'terminal',
            'dashboard',
          },
          buftype_exclude = { 'terminal' },
          char_list = { '|', '¦', '┆', '┊' },
          space_char_blankline = ' ',
          show_first_indent_level = false,
          show_current_context = true,
        }
      end,
    }

    -- Dashboard
    use 'glepnir/dashboard-nvim'

    -- Tree Explorer
    use {
      'kyazdani42/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      config = function()
        require('plugins.configs.nvim-tree').setup()
      end,
    }

    -- Which Key
    use {
      'folke/which-key.nvim',
      config = function()
        require 'plugins.configs.which-key'
      end,
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require 'plugins.configs.treesitter'
      end,
      run = ':TSUpdate',
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
    use {
      'ahmedkhalf/project.nvim',
      config = function()
        require 'plugins.configs.project'
      end,
    }
    use { 'jdhao/better-escape.vim', event = 'InsertEnter' }
    use { 'michaelb/sniprun', cmd = 'SnipRun', run = 'bash ./install.sh' }
    use 'dstein64/vim-startuptime'

    -- Language Specific
    use { 'npxbr/glow.nvim', cmd = 'Glow' }
    use {
      'simrat39/rust-tools.nvim',
      config = function()
        require('rust-tools').setup {}
      end,
      ft = 'rust',
    }
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = 'markdown',
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

    -- Utils
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'ekickx/clipboard-image.nvim',
      config = function()
        require('clipboard-image').setup {}
      end,
    }
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer_compiled.lua',
  },
}
