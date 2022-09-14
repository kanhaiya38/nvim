local M = {}

M.lsp = function(bufnr)
  local custom_hover = function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      require('lspsaga.hover'):render_hover_doc()
    end
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  require('utils').set_keymaps({
    mappings = {
      ['gD'] = { vim.lsp.buf.declaration, 'declaration' },
      ['gd'] = { vim.lsp.buf.definition, 'declaration' },
      ['gK'] = {
        function()
          require('lspsaga.definition'):peek_definition()
        end,
        'definition',
      },
      ['K'] = { custom_hover, 'hover' },
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
      ['<space>rn'] = {
        function()
          require('lspsaga.rename'):lsp_rename()
        end,
        'rename',
      },
      ['<space>ca'] = {
        function()
          require('lspsaga.codeaction'):code_action()
        end,
        'code action',
      },
      ['gR'] = { vim.lsp.buf.references, 'references' },
      -- ['<space>f'] = { vim.lsp.buf.formatting, 'format' },
    },
    opts = { buffer = bufnr },
  })
end

M.packer = function()
  require('utils').set_keymaps({
    mappings = {
      ['<leader>pd'] = {
        function()
          require('packer').clean()
        end,
        'clean',
      },
      ['<leader>pc'] = {
        function()
          require('packer').compile()
        end,
        'compile',
      },
      ['<leader>pi'] = {
        function()
          require('packer').install()
        end,
        'install',
      },
      ['<leader>ps'] = {
        function()
          require('packer').sync()
        end,
        'sync',
      },
      ['<leader>pS'] = {
        function()
          require('packer').status()
        end,
        'status',
      },
      ['<leader>pu'] = { '<cmd>PackerUpdate<CR>', 'update' },
    },
  })
end

M.telescope = function()
  require('utils').set_keymaps({
    mappings = {
      ['<leader>ff'] = {
        function()
          require('configs.telescope').project_files()
        end,
        'find_files',
      },
      ['<leader>fz'] = {
        function()
          require('telescope.builtin').live_grep()
        end,
        'find_files',
      },
    },
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

  require('utils').set_keymaps({
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

  require('utils').set_keymaps({
    mappings = {
      -- Go to buffer
      ['[b'] = { cycle(-1), 'prev buffer' },
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
  })
end

M.nvim_tree = function()
  require('utils').set_keymaps({
    mappings = {
      ['<c-n>'] = {
        function()
          require('nvim-tree').toggle()
        end,
        'tree toggle',
      },
    },
    mode = { 'n', 'i', 't' },
  })
end

M.toggleterm = function()
  require('utils').set_keymaps({
    mappings = {
      ['<leader>tl'] = {
        function()
          require('configs.toggleterm').lazygit:toggle()
        end,
        'lazygit',
      },
      ['<C-Space>'] = { '<Cmd>ToggleTerm<CR>', 'open terminal' },
    },
  })
end

M.ufo = function()
  require('utils').set_keymaps({
    mappings = {
      ['zR'] = {
        function()
          require('ufo').openAllFolds()
        end,
        'open folds',
      },
      ['zM'] = {
        function()
          require('ufo').closeAllFolds()
        end,
        'close folds',
      },
    },
  })
end

-- map('n', '<leader>d', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>D', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<leader>o', '<Cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
-- map('n', '<leader>O', '<Cmd>set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)

M.typescript = function()
  require('utils').set_keymaps({
    mappings = {
      ['<leader>ti'] = {
        function()
          require('typescript').actions.addMissingImports()
        end,
        'add missing imports',
      },
      ['<leader>to'] = {
        function()
          require('typescript').actions.organizeImports()
        end,
        'organize imports',
      },
      ['<leader>tr'] = {
        function()
          require('typescript').actions.removeUnused()
        end,
        'remove unused',
      },
    },
  })
end

M.defaults = function()
  require('utils').set_keymaps({
    mappings = {
      -- Windows
      ['<c-j>'] = { '<esc><cmd>wincmd j<cr>', 'down' },
      ['<c-k>'] = { '<esc><cmd>wincmd k<cr>', 'up' },
      ['<c-h>'] = { '<esc><cmd>wincmd h<cr>', 'left' },
      ['<c-l>'] = { '<esc><cmd>wincmd l<cr>', 'right' },

      -- Buffer
      ['<c-q>'] = { '<cmd>Bdelete<cr>', 'delete buffer' },
      ['<C-y>'] = { 'ggVG"+y', 'copy buffer' },
    },
    mode = { 'n', 'i', 't' },
  })

  require('utils').set_keymaps({
    mappings = {
      -- Diagnostics
      ['<space>e'] = {
        function()
          require('lspsaga.diagnostic').show_cursor_diagnostics()
        end,
        'open diagnostics',
      },
      ['<space>E'] = {
        function()
          require('lspsaga.diagnostic').show_line_diagnostics()
        end,
        'open line diagnostic',
      },
      ['[d'] = {
        function()
          require('lspsaga.diagnostic').goto_prev()
        end,
        'prev diagnostic',
      },
      [']d'] = {
        function()
          require('lspsaga.diagnostic').goto_next()
        end,
        'next diagnostic',
      },
      ['<space>q'] = { vim.diagnostic.setloclist, 'setloclist' },
    },
  })
end

return M
