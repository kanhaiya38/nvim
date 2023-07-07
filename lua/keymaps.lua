local M = {}

M.lsp = function(bufnr)
  require('utils').set_keymaps({
    mappings = {
      ['gD'] = { vim.lsp.buf.declaration, 'declaration' },
      ['gd'] = { vim.lsp.buf.definition, 'declaration' },
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
      -- ['<space>ca'] = { vim.lsp.buf.code_action, 'code action' },
      ['gR'] = { vim.lsp.buf.references, 'references' },
    },
    opts = { buffer = bufnr },
  })
end

---@type LazyKeys[]
M.lspsaga = {
  { 'gh', '<cmd>Lspsaga lsp_finder<CR>' },
  { '<leader>ca', '<cmd>Lspsaga code_action<CR>', mode = { 'n', 'v' } },
  { 'gr', '<cmd>Lspsaga rename<CR>' },
  { 'gr', '<cmd>Lspsaga rename ++project<CR>' },
  { 'gp', '<cmd>Lspsaga peek_definition<CR>' },
  { 'gd', '<cmd>Lspsaga goto_definition<CR>' },
  { 'gt', '<cmd>Lspsaga peek_type_definition<CR>' },
  { 'gt', '<cmd>Lspsaga goto_type_definition<CR>' },
  { '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>' },
  { '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>' },
  { '<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics<CR>' },
  { '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>' },
  { '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>' },
  { ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>' },
}

---@type LazyKeys[]
M.null_ls = {
  { '<Leader>af', vim.lsp.buf.format, desc = 'format' },
}

---@type LazyKeys[]
M.lazy = {
  {
    '<Leader>lh',
    function()
      require('lazy').home()
    end,
    desc = 'lazy',
  },
  {
    '<Leader>lp',
    function()
      require('lazy').profile()
    end,
    desc = 'profile',
  },
}

M.telescope = function()
  local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
      require('telescope.builtin').find_files(opts)
    end
  end

  require('utils').set_keymaps({
    mappings = {
      ['<Leader>ff'] = { project_files, 'find_files' },
      ['<Leader>fo'] = {
        function()
          require('telescope.builtin').resume()
        end,
        'resume',
      },
      ['<Leader>fa'] = {
        function()
          require('telescope.builtin').find_files()
        end,
        'find_files',
      },
      ['<Leader>fs'] = {
        function()
          require('telescope.builtin').grep_string()
        end,
        'grep_string',
      },
      ['<Leader>fg'] = {
        function()
          require('telescope').extensions.live_grep_args.live_grep_args()
        end,
        'live_grep_args',
      },
      ['<Leader>fz'] = {
        function()
          require('telescope.builtin').live_grep()
        end,
        'live_grep',
      },
      ['<Leader>fp'] = {
        function()
          require('telescope').extensions.projects.projects({})
        end,
        'projects',
      },
    },
  })
end

---@type LazyKeys[]
M.refactoring = {
  {
    '<leader>rp',
    function()
      require('refactoring').debug.printf({ below = false })
    end,
  },
  {
    '<leader>rv',
    function()
      require('refactoring').debug.print_var({ normal = true })
    end,
  },
  {
    '<leader>rc',
    function()
      require('refactoring').debug.cleanup({})
    end,
  },
  {

    '<leader>rv',
    function()
      require('refactoring').debug.print_var({})
    end,
    mode = 'v',
  },
}

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
      ['<Leader>hs'] = { ':Gitsigns stage_hunk<CR>', 'stage_hunk', mode = { 'n', 'v' } },
      ['<Leader>hr'] = { ':Gitsigns reset_hunk<CR>', 'reset_hunk', mode = { 'n', 'v' } },
      ['<Leader>hS'] = { gs.stage_buffer, 'stage_buffer' },
      ['<Leader>hu'] = { gs.undo_stage_hunk, 'undo_stage_hunk' },
      ['<Leader>hR'] = { gs.reset_buffer, 'reset_buffer' },
      ['<Leader>hp'] = { gs.preview_hunk, 'preview_hunk' },
      ['<Leader>hb'] = { blame_line, 'blame_line' },
      ['<Leader>tb'] = { gs.toggle_current_line_blame, 'stage_buffer' },
      ['<Leader>hd'] = { gs.diffthis, 'stage_buffer' },
      ['<Leader>hD'] = { diffthis, 'diffthis' },
      ['<Leader>td'] = { gs.toggle_deleted, 'stage_buffer' },
      -- Text object
      ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', 'stage_hunk', mode = { 'o', 'x' } },
    },
    opts = { buffer = bufnr },
  })
end

M.diffview = function()
  require('utils').set_keymaps({
    mappings = {
      ['<Space>do'] = { '<Cmd>DiffviewOpen<CR>', 'diff' },
      ['<Space>dc'] = { '<Cmd>DiffviewClose<CR>', 'close' },
    },
  })
end

M.bufferline = function()
  local go_to_buffer = function(num)
    return function()
      require('bufferline').go_to_buffer(num, true)
    end
  end

  local cycle = function(num)
    return function()
      require('bufferline').cycle(num)
    end
  end

  require('utils').set_keymaps({
    mappings = {
      -- Go to buffer
      ['[b'] = { cycle(-1), 'prev buffer' },
      [']b'] = { cycle(1), 'next buffer' },
      ['<Leader>1'] = { go_to_buffer(1), 'go to buffer 1' },
      ['<Leader>2'] = { go_to_buffer(2), 'go to buffer 2' },
      ['<Leader>3'] = { go_to_buffer(3), 'go to buffer 3' },
      ['<Leader>4'] = { go_to_buffer(4), 'go to buffer 4' },
      ['<Leader>5'] = { go_to_buffer(5), 'go to buffer 5' },
      ['<Leader>6'] = { go_to_buffer(6), 'go to buffer 6' },
      ['<Leader>7'] = { go_to_buffer(7), 'go to buffer 7' },
      ['<Leader>8'] = { go_to_buffer(8), 'go to buffer 8' },
      ['<Leader>9'] = { go_to_buffer(9), 'go to buffer 9' },
      ['<Leader>0'] = { go_to_buffer(-1), 'go to buffer 0' },
    },
  })
end

M.neo_tree = function()
  require('utils').set_keymaps({
    mappings = {
      ['<C-n>'] = {
        function()
          require('neo-tree.command').execute({ toggle = true, reveal = true })
        end,
        'tree toggle',
      },
    },
    mode = { 'n', 'i', 't' },
  })
end

---@type LazyKeys[]
M.toggleterm = {
  { '<C-Space>' },
  {
    '<Leader>tl',
    function()
      require('utils.toggleterm').lazygit()
    end,
    'lazygit',
  },
}

---@type LazyKeys[]
M.ufo = {
  {
    'zR',
    function()
      require('ufo').openAllFolds()
    end,
    desc = 'open folds',
  },
  {
    'zM',
    function()
      require('ufo').closeAllFolds()
    end,
    desc = 'close folds',
  },
}

---@type LazyKeys[]
M.noice = {
  {
    '<Leader>ad',
    function()
      require('noice').cmd('dismiss')
    end,
    desc = 'dismiss notifications',
  },
}

---@type LazyKeys[]
M.guess_indent = {
  {
    '<Leader>ai',
    function()
      require('guess-indent').set_from_buffer()
    end,
    desc = 'guess indent',
  },
}

-- map('n', '<Leader>d', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<Leader>D', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>', opts)
-- map('n', '<Leader>o', '<Cmd>set paste<CR>m`o<Esc>``:set nopaste<CR>', opts)
-- map('n', '<Leader>O', '<Cmd>set paste<CR>m`O<Esc>``:set nopaste<CR>', opts)

M.typescript = function(bufnr)
  require('utils').set_keymaps({
    mappings = {
      ['<Leader>ti'] = {
        function()
          require('typescript').actions.addMissingImports()
        end,
        'add missing imports',
      },
      ['<Leader>to'] = {
        function()
          require('typescript').actions.organizeImports()
        end,
        'organize imports',
      },
      ['<Leader>tr'] = {
        function()
          require('typescript').actions.removeUnused()
        end,
        'remove unused',
      },
    },
    opts = { buffer = bufnr },
  })
end

M.treesj = {
  {
    '<Leader>aj',
    function()
      require('treesj').toggle()
    end,
    desc = 'treesj toggle',
  },
}

---@type LazyKeys[]

M.defaults = function()
  local set_keymaps = require('utils').set_keymaps
  set_keymaps({
    mappings = {
      -- Windows
      ['<C-j>'] = { '<Esc><Cmd>wincmd j<CR>', 'down' },
      ['<C-k>'] = { '<Esc><Cmd>wincmd k<CR>', 'up' },
      ['<C-h>'] = { '<Esc><Cmd>wincmd h<CR>', 'left' },
      ['<C-l>'] = { '<Esc><Cmd>wincmd l<CR>', 'right' },
      -- Buffer
      ['<C-q>'] = { '<Cmd>Bdelete<CR>', 'delete buffer' },
    },
    mode = { 'n', 'i', 't' },
  })

  set_keymaps({
    mappings = {
      -- Diagnostics
      ['<space>e'] = { vim.diagnostic.open_float, 'open diagnostics' },
      ['[d'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
      [']d'] = { vim.diagnostic.goto_next, 'next diagnostic' },
      ['<space>q'] = { vim.diagnostic.setloclist, 'setloclist' },
    },
  })

  set_keymaps({
    mappings = {
      -- ['p'] = { '<Cmd>MarkdownPreview<CR>', 'markdown preview' },
      ['<Space>am'] = { '<Cmd>MarkdownPreview<CR>', 'markdown preview' },
      ['<Space>ap'] = { '<Cmd>PasteImg<CR>', 'paste image' },
      ['<Space>ac'] = { '<Cmd>silent !pandoc -V documentclass=scrreprt % -o %:r.pdf<CR>', 'pandoc' },
    },
  })
end

return M
