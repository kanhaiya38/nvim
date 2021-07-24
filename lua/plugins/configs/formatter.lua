require('formatter').setup {
  logging = false,
  filetype = {
    javascript = {
      function()
        return {
          exe = './node_modules/.bin/prettier',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    python = {
      function()
        return { exe = 'black', args = { '-' }, stdin = true }
      end,
    },
    rust = {
      function()
        return {
          exe = 'rustfmt',
          args = { '--emit=stdout' },
          stdin = true,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = 'stylua',
          args = {},
          stdin = false,
        }
      end,
    },
    cpp = {
      function()
        return {
          exe = 'clang-format',
          args = {},
          stdin = true,
          cwd = vim.fn.expand '%:p:h', -- Run clang-format in cwd of the file.
        }
      end,
    },
  },
}
