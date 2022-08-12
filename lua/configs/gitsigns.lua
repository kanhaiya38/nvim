local utils = require('utils')

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
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
      -- Navigation
      [']c'] = { next_hunk, 'next_hunk', { expr = true } },
      ['[c'] = { prev_hunk, 'prev_hunk', { expr = true } },

      -- Actions
      ['<leader>hs'] = { ':Gitsigns stage_hunk<CR>', 'stage_hunk', nil, { 'n', 'v' } },
      ['<leader>hr'] = { ':Gitsigns reset_hunk<CR>', 'reset_hunk', nil, { 'n', 'v' } },
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
      ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'stage_hunk', nil, { 'o', 'x' } },
    }, { buffer = bufnr })
  end,
})
