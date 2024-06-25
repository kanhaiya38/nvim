---@type LazySpec
local plugins = {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    keys = {
      { '<leader>cp', '<Cmd>Copilot panel<CR>' },
    },
    config = function()
      require('copilot').setup({
        panel = {
          layout = { position = 'right' },
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'hrsh7th/nvim-cmp' },
    },
    event = 'InsertEnter',
    config = function()
      require('copilot_cmp').setup({
        suggestion = { enabled = false },
      })
    end,
  },
}

return plugins
