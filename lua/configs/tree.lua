local M = {}
M.setup = function()
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
  })
end

return M
