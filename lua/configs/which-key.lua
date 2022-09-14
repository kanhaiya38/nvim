local M = {}

M.setup = function()
  local wk = require('which-key')

  wk.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  })

  wk.register({
    ['<leader>a'] = {
      name = '+actions',
      f = { '<cmd>lua vim.lsp.buf.format { async = true }<CR>', 'format' },
      g = { '<cmd>Glow<CR>', 'glow' },
      d = { require('notify').dismiss, 'dismiss notification' },
      m = { '<cmd>MarkdownPreview<CR>', 'markdown preview' },
      p = { '<cmd>PasteImg<CR>', 'paste image' },
      c = { '<cmd>silent !pandoc -V documentclass=scrreprt % -o %:r.pdf<CR>', 'pandoc' },
    },

    ['<leader>x'] = {
      name = '+leetcode',
      a = {
        '<cmd>lua require("configs.toggleterm").exec("leetcode show " .. vim.fn.expand("%:r:r") .. " --solution")<CR>',
        'solution',
      },
      s = { '<cmd>lua require("configs.toggleterm").exec("leetcode show " .. vim.fn.expand("%:r:r"))<CR>', 'show' },
      S = { '<cmd>lua require("configs.toggleterm").exec("leetcode submit " .. vim.fn.expand("%"))<CR>', 'submit' },
      t = {
        '<cmd>lua require("configs.toggleterm").exec("leetcode test " .. vim.fn.expand("%") .. " --local")<CR>',
        'local test',
      },
      T = { '<cmd>lua require("configs.toggleterm").exec("leetcode test " .. vim.fn.expand("%"))<CR>', 'test' },
    },

    ['<leader>u'] = { '<cmd>lua require("functions").openURL()<CR>', 'open url' },
    ['['] = { name = '+goto' },
    [']'] = { name = '+goto' },
  })
end

return M
