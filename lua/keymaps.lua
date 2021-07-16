local map = vim.api.nvim_set_keymap

-- Escape
local opts = { noremap = true }

map('i', 'jj', '<Esc>', opts)
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)

opts = { noremap = true, silent = true }
map('n', '<C-n>', ':lua require("plugins.configs.nvim-tree").toggle()<CR>', opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)
