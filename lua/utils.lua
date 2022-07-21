local wk = require('which-key')

local M = {}

-- defaults:
-- {
--   mode = "n",
--   prefix = "",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- }
M.set_keymaps = function(mappings, opts, mode)
  if type(mappings) ~= 'table' then
    vim.notify_once('[utils.set_keymaps] Invalid mappings ' .. (mappings or 'nil'), vim.log.levels.ERROR)
    return
  end

  if type(mode) == 'table' then
    for _, mode_val in ipairs(mode) do
      M.set_keymaps(mappings, opts, mode_val)
    end
    return
  end

  opts = vim.tbl_deep_extend('force', opts or {}, { mode = mode })
  wk.register(mappings, opts)
end

return M
