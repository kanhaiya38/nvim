local M = {}

M.setup = function()
  local wk = require('which-key')

  wk.setup()

  wk.register({
    ['['] = { name = '+goto' },
    [']'] = { name = '+goto' },
  })
end

return M
