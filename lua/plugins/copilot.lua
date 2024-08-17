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
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    cmd = { 'CopilotChat' },
    keys = {
      {
        '<leader>cb',
        function()
          local input = vim.fn.input('Quick Chat: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      mappings = {
        reset = {
          normal = '<leader>r',
        },
      },
    },
  },
}

return plugins
