---@type LazySpec
local plugins = {
  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- Tell Neorg what modules to load
      load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              home = '~/Kanhaiya/neorg',
            },
          },
        },
      },
    },
  },
}

return plugins
