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
  bootstrap()

  require('lazy').setup('plugins', {
    defaults = {
      lazy = true,
    },
    install = {
      -- try to load one of these colorschemes when starting an installation during startup
      colorscheme = { 'onedark' },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'editorconfig',
          'gzip',
          'man.lua',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'rplugin',
          'shada',
          'spellfile',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  })
end

return M
