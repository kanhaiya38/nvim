local M = {}
M.setup = function()
  require('neo-tree').setup({
    window = {
      width = 30,
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },
  })
end

return M
