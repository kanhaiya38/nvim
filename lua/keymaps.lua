local utils = require('utils')

-- Windows
local windows = {
  ['<c-j>'] = { '<esc><cmd>wincmd j<cr>', 'down' },
  ['<c-k>'] = { '<esc><cmd>wincmd k<cr>', 'up' },
  ['<c-h>'] = { '<esc><cmd>wincmd h<cr>', 'left' },
  ['<c-l>'] = { '<esc><cmd>wincmd l<cr>', 'right' },
}

local buffer = {
  ['<c-q>'] = { '<cmd>Bdelete<cr>', 'delete buffer' },
  ['<C-y>'] = { 'ggVG"+y', 'copy buffer' },
}

-- NvimTree
local nvim_tree = {
  ['<c-n>'] = { '<esc><cmd>NvimTreeToggle<cr>', 'tree toggle' },
}

-- ToggleTerm
local toggleterm = {
  ['<C-Space>'] = { '<Cmd>ToggleTerm<CR>', 'open terminal' },
}

local opts = { nowait = true }

utils.set_keymaps(windows, opts, { 'n', 'i', 't' })
utils.set_keymaps(buffer, opts, { 'n', 'i', 't' })
utils.set_keymaps(nvim_tree, opts, { 'n', 'i', 't' })
utils.set_keymaps(toggleterm, opts)

local diagnostic = {
  ['<space>e'] = { vim.diagnostic.open_float, 'open diagnostic' },
  ['[d'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
  [']d'] = { vim.diagnostic.goto_next, 'next diagnostic' },
  ['<space>q'] = { vim.diagnostic.setloclist, 'setloclist' },
}
utils.set_keymaps(diagnostic)

-- map('n', '<leader>d', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>D', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>o', '<Cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
-- map('n', '<leader>O', '<Cmd>set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)
