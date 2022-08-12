local M = {}

M.set_keymaps = function(mappings, opts, mode)
  mode = mode or 'n'
  for key, val in pairs(mappings) do
    local lhs = key
    local rhs = val[1]
    opts = vim.tbl_deep_extend('force', opts or {}, { desc = val[2] })
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
