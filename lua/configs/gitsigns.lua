local M = {}

M.setup = function()
  require('gitsigns').setup({
    current_line_blame = true,
    on_attach = require('keymaps').gitsigns,
    yadm = {
      enable = true,
    },
  })
end

return M
