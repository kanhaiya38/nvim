---@type LazySpec
local plugins = {
  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    ft = 'norg',
    cmd = 'Neorg',
    opts = {
      -- Tell Neorg what modules to load
      load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.norg.concealer'] = {}, -- Allows for use of icons
        ['core.norg.dirman'] = { -- Manage your directories with Neorg
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
