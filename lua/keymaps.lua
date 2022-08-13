local M = {}

local utils = require('utils')

M.lsp = function(bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  utils.set_keymaps({
    mappings = {
      ['gD'] = { vim.lsp.buf.declaration, 'declaration' },
      ['gd'] = { vim.lsp.buf.definition, 'definition' },
      ['K'] = { vim.lsp.buf.hover, 'hover' },
      ['gI'] = { vim.lsp.buf.implementation, 'implementation' },
      ['gh'] = { vim.lsp.buf.signature_help, 'signature_help' },
      ['<space>wa'] = { vim.lsp.buf.add_workspace_folder, 'add workspace' },
      ['<space>wr'] = { vim.lsp.buf.remove_workspace_folder, 'remove workspace' },
      ['<space>wl'] = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        'list workspace',
      },
      ['<space>D'] = { vim.lsp.buf.type_definition, 'type definition' },
      ['<space>rn'] = { vim.lsp.buf.rename, 'rename' },
      ['<space>ca'] = { vim.lsp.buf.code_action, 'code action' },
      ['gR'] = { vim.lsp.buf.references, 'references' },
      ['<space>f'] = { vim.lsp.buf.formatting, 'format' },
    },
    opts = { noremap = true, silent = true, buffer = bufnr },
  })
end

M.gitsigns = function(bufnr)
  local gs = package.loaded.gitsigns

  local next_hunk = function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end

  local prev_hunk = function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end

  local blame_line = function()
    gs.blame_line({ full = true })
  end
  local diffthis = function()
    gs.diffthis('~')
  end

  utils.set_keymaps({
    mappings = {
      -- Navigation
      [']c'] = { next_hunk, 'next_hunk', opts = { expr = true } },
      ['[c'] = { prev_hunk, 'prev_hunk', opts = { expr = true } },

      -- Actions
      ['<leader>hs'] = { ':Gitsigns stage_hunk<CR>', 'stage_hunk', mode = { 'n', 'v' } },
      ['<leader>hr'] = { ':Gitsigns reset_hunk<CR>', 'reset_hunk', mode = { 'n', 'v' } },
      ['<leader>hS'] = { gs.stage_buffer, 'stage_buffer' },
      ['<leader>hu'] = { gs.undo_stage_hunk, 'undo_stage_hunk' },
      ['<leader>hR'] = { gs.reset_buffer, 'reset_buffer' },
      ['<leader>hp'] = { gs.preview_hunk, 'preview_hunk' },
      ['<leader>hb'] = { blame_line, 'blame_line' },
      ['<leader>tb'] = { gs.toggle_current_line_blame, 'stage_buffer' },
      ['<leader>hd'] = { gs.diffthis, 'stage_buffer' },
      ['<leader>hD'] = { diffthis, 'diffthis' },
      ['<leader>td'] = { gs.toggle_deleted, 'stage_buffer' },

      -- Text object
      ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'stage_hunk', mode = { 'o', 'x' } },
    },
    opts = { buffer = bufnr },
  })
end

M.bufferline = function()
  local bl = require('bufferline')
  local go_to_buffer = function(num)
    return function()
      bl.go_to_buffer(num, true)
    end
  end

  local cycle = function(num)
    return function()
      bl.cycle(num)
    end
  end

  utils.set_keymaps({
    mappings = {
      -- Go to buffer
      ['[b'] = { 'kan', 'prev buffer' },
      [']b'] = { cycle(1), 'next buffer' },
      ['<leader>1'] = { go_to_buffer(1), 'go to buffer 1' },
      ['<leader>2'] = { go_to_buffer(2), 'go to buffer 2' },
      ['<leader>3'] = { go_to_buffer(3), 'go to buffer 3' },
      ['<leader>4'] = { go_to_buffer(4), 'go to buffer 4' },
      ['<leader>5'] = { go_to_buffer(5), 'go to buffer 5' },
      ['<leader>6'] = { go_to_buffer(6), 'go to buffer 6' },
      ['<leader>7'] = { go_to_buffer(7), 'go to buffer 7' },
      ['<leader>8'] = { go_to_buffer(8), 'go to buffer 8' },
      ['<leader>9'] = { go_to_buffer(9), 'go to buffer 9' },
      ['<leader>0'] = { go_to_buffer(-1), 'go to buffer 0' },
    },
    opts = { silent = true, noremap = true },
  })
end

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

local opts = { noremap = true, silent = true, nowait = true }

utils.set_keymaps({ mappings = windows, opts = opts, modes = { 'n', 'i', 't' } })
utils.set_keymaps({ mappings = buffer, opts = opts, modes = { 'n', 'i', 't' } })
utils.set_keymaps({ mappings = nvim_tree, opts = opts, modes = { 'n', 'i', 't' } })
utils.set_keymaps({ mappings = toggleterm, opts = opts })

local diagnostic = {
  ['<space>e'] = { vim.diagnostic.open_float, 'open diagnostic' },
  ['[d'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
  [']d'] = { vim.diagnostic.goto_next, 'next diagnostic' },
  ['<space>q'] = { vim.diagnostic.setloclist, 'setloclist' },
}
utils.set_keymaps({ mappings = diagnostic })

-- map('n', '<leader>d', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>D', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>o', '<Cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
-- map('n', '<leader>O', '<Cmd>set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)
return M
