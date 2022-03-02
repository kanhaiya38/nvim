require('neorg').setup {
  -- Tell Neorg what modules to load
  load = {
    ['core.defaults'] = {}, -- Load all the default modules
    ['core.norg.concealer'] = {}, -- Allows for use of icons
    ['core.norg.dirman'] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          home = '~/Kanhaiya/Codes/neorg',
        },
      },
    },
    ['core.norg.completion'] = {
      config = { -- Note that this table is optional and doesn't need to be provided
        -- Configuration here
        engine = 'nvim-cmp',
      },
    },
  },
}
