local map = vim.api.nvim_set_keymap

local opts = { noremap = true }

-- Windows
map('n', '<C-q>', '<Cmd>bw<CR>', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
--
map('i', '<C-j>', '<C-\\><C-n><C-w>j', opts)
map('i', '<C-k>', '<C-\\><C-n><C-w>k', opts)
map('i', '<C-h>', '<C-\\><C-n><C-w>h', opts)
map('i', '<C-l>', '<C-\\><C-n><C-w>l', opts)

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>', opts)
map('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
map('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
map('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
map('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)

opts = { noremap = true, silent = true }
map('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)

-- ToggleTerm
opts = { noremap = true, silent = true, nowait = true }
map('n', '<C-Space>', '<Cmd>ToggleTerm<CR>', opts)
