local M = {}

M.setup = function()
  require('gitsigns').setup({
    current_line_blame = true,
    on_attach = function(bufnr)
      require('keymaps').gitsigns(bufnr)
    end,
    yadm = {
      enable = true,
    },
  })
end

return M
