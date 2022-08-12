local M = {}

M.set_keymaps = function(mappings, opts, mode, debug)
  opts = opts or {}
  mode = mode or 'n'

  for key, val in pairs(mappings) do
    local lhs = key
    local rhs = val[1]
    local desc = val[2]
    local local_opts = val[3] or {}
    local local_mode = val[4] or mode
    local_opts = vim.tbl_deep_extend('force', opts, local_opts, { desc = desc })
    if debug then
      vim.pretty_print('mode', local_mode)
      vim.pretty_print('lhs', lhs)
      vim.pretty_print('rhs', rhs)
      vim.pretty_print('opts', local_opts)
    end
    vim.keymap.set(local_mode, lhs, rhs, local_opts)
  end
end

return M
