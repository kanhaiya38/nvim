local map = vim.api.nvim_set_keymap

-- Escape
local opts = { noremap = true }

map('i', 'jj', '<Esc>', opts)
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)

map('n', '<C-J>', '<C-w>j', opts)
map('n', '<C-K>', '<C-w>k', opts)
map('n', '<C-H>', '<C-w>h', opts)
map('n', '<C-L>', '<C-w>l', opts)

opts = { noremap = true, silent = true }
map('n', '<C-n>', ':lua require("plugins.configs.nvim-tree").toggle()<CR>', opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)
