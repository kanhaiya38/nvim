---@class FileMovedArgs
---@field source string
---@field destination string

---@param args FileMovedArgs
local function on_file_remove(args)
  local ts_clients = vim.lsp.get_active_clients({ name = 'tsserver' })
  for _, ts_client in ipairs(ts_clients) do
    ts_client.request('workspace/executeCommand', {
      command = '_typescript.applyRenameFile',
      arguments = {
        {
          sourceUri = vim.uri_from_fname(args.source),
          targetUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

local config = function()
  local events = require('neo-tree.events')

  require('neo-tree').setup({
    close_if_last_window = true,
    window = {
      width = 30,
      mappings = {
        ['f'] = function()
          vim.api.nvim_exec('Neotree focus filesystem left', true)
        end,
        ['b'] = function()
          vim.api.nvim_exec('Neotree focus buffers left', true)
        end,
        ['g'] = function()
          vim.api.nvim_exec('Neotree focus git_status left', true)
        end,
        ['l'] = 'open',
        ['h'] = 'close_node',
      },
    },
    filesystem = {
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },
    event_handlers = {
      {
        event = events.FILE_MOVED,
        handler = on_file_remove,
      },
      {
        event = events.FILE_RENAMED,
        handler = on_file_remove,
      },
    },
  })
end

---@type LazySpec
local plugins = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    init = require('keymaps').neo_tree,
    config = config,
    cmd = { 'NeoTreeClose' },
    dependencies = 'MunifTanjim/nui.nvim',
  },
}

return plugins
