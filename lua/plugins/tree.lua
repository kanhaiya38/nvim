---@class FileMovedArgs
---@field source string
---@field destination string

---@param args FileMovedArgs
local function on_file_remove(args)
  local ts_clients = vim.lsp.get_clients({ name = 'tsserver' })
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
      width = 36,
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },
    default_component_configs = {
      file_size = { enabled = false },
      type = {
        enabled = true,
        required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
        enabled = true,
        required_width = 88, -- min width of window required to show this column
      },
      created = {
        enabled = true,
        required_width = 110, -- min width of window required to show this column
      },
      symlink_target = {
        enabled = false,
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
    config = config,
    keys = require('keymaps').neo_tree,
    cmd = { 'Neotree' },
    dependencies = 'MunifTanjim/nui.nvim',
  },
}

return plugins
