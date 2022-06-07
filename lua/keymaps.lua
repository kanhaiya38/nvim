local map = vim.keymap.set

-- Windows
map('n', '<C-q>', '<Cmd>Bdelete<CR>')
map({ 'n', 'i', 't' }, '<C-j>', '<Esc><Cmd>wincmd j<CR>')
map({ 'n', 'i', 't' }, '<C-k>', '<Esc><Cmd>wincmd k<CR>')
map({ 'n', 'i', 't' }, '<C-h>', '<Esc><Cmd>wincmd h<CR>')
map({ 'n', 'i', 't' }, '<C-l>', '<Esc><Cmd>wincmd l<CR>')

map({ 'n', 'i', 't' }, '<C-n>', '<Esc><Cmd>NvimTreeToggle<CR>')

-- Lspsaga
-- map('n', '<C-j>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
-- map('n', '<C-k>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)

local opts = { silent = true, nowait = true }

-- ToggleTerm
map('n', '<C-Space>', '<Cmd>ToggleTerm<CR>', opts)

map('n', '<C-y>', 'ggVG"+y', opts)
map('n', '<leader>d', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
map('n', '<leader>D', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
map('n', '<leader>o', '<Cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
map('n', '<leader>O', '<Cmd>set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)
