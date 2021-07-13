local map = vim.api.nvim_set_keymap

-- Escape
local opts = { noremap = true }

map('i', 'jj', '<Esc>', opts)
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)
