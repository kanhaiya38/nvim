require('which-key').setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local wk = require 'which-key'

wk.register {
  ['<leader>a'] = {
    name = '+actions',
    f = { '<cmd>lua vim.lsp.buf.format { async = true }<CR>', 'format' },
    g = { '<cmd>Glow<CR>', 'glow' },
    m = { '<cmd>MarkdownPreview<CR>', 'markdown preview' },
    p = { '<cmd>PasteImg<CR>', 'paste image' },
    c = { '<cmd>silent !pandoc -V documentclass=scrreprt % -o %:r.pdf<CR>', 'pandoc' },
  },

  ['<leader>b'] = {
    name = '+buffer',
    a = { '<cmd>BufferLineCloseLeft<CR> | <cmd>BufferLineCloseRight<CR>', 'close all but current' },
    r = { '<cmd>BufferLineCloseRight<CR>', 'close all buffers right' },
    l = { '<cmd>BufferLineCloseLeft<CR>', 'close all buffers left' },
    D = { '<cmd>BufferLineSortByDirectory<CR>', 'order by directory' },
    E = { '<cmd>BufferLineSortByExtension<CR>', 'order by extension' },
    T = { '<cmd>BufferLineSortByTabs<CR>', 'order by tabs' },
    z = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'buffer fuzzy find' },
    t = { '<cmd>Telescope current_buffer_tags<CR>', 'buffer tags' },
  },

  ['<leader>f'] = {
    name = '+file',
    f = { '<cmd>Telescope find_files<CR>', 'find files' },
    g = { '<cmd>Telescope git_files<CR>', 'git files' },
    h = { '<cmd>Telescope oldfiles<CR>', 'recent files' },
    s = { '<cmd>Telescope grep_string<CR>', 'grep string' },
    z = { '<cmd>Telescope live_grep<CR>', 'live grep' },
    p = { '<cmd>Telescope projects<CR>', 'projects' },
  },

  ['<leader>s'] = {
    name = '+search',
    b = { '<cmd>Telescope buffers<CR>', 'buffers' },
    c = { '<cmd>Telescope commands<CR>', 'commands' },
    t = { '<cmd>Telescope tags<CR>', 'tags' },
    m = { '<cmd>Telescope marks<CR>', 'marks' },
    q = { '<cmd>Telescope quickfix<CR>', 'quickfix' },
    o = { '<cmd>Telescope vim_options<CR>', 'vim options' },
    r = { '<cmd>Telescope registers<CR>', 'registers' },
    a = { '<cmd>Telescope autocommands<CR>', 'autocommands' },
    s = { '<cmd>Telescope spell_suggest<CR>', 'spell suggest' },
    k = { '<cmd>Telescope keymaps<CR>', 'keymaps' },
  },

  ['<leader>l'] = {
    name = '+lsp',
    r = { '<cmd>Telescope lsp_references<CR>', 'reference' },
    s = { '<cmd>Telescope lsp_document_symbols<CR>', 'document symbols' },
    d = { '<cmd>Telescope diagnostics bufnr=0<CR>', 'document diagnostic' },
    i = { '<cmd>Telescope lsp_implementations<CR>', 'implementations' },
    D = { '<cmd>Telescope lsp_definitions<CR>', 'definitions' },
    f = { '<cmd>lua vim.lsp.buf.range_formatting()<CR>', 'format' },
  },

  ['<leader>w'] = {
    s = { '<cmd>Telescope lsp_workspace_symbols<CR>', 'workspace symbols' },
    S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'dynamic workspace symbols' },
    d = { '<cmd>Telescope diagnostics<CR>', 'workspace diagnostic' },
  },

  ['<leader>g'] = {
    name = '+git',
    c = { '<cmd>Telescope git_commits<CR>', 'commits' },
    C = { '<cmd>Telescope git_bcommits<CR>', 'buffer commits' },
    b = { '<cmd>Telescope git_branches<CR>', 'branches' },
    s = { '<cmd>Telescope git_status<CR>', 'status' },
    S = { '<cmd>Telescope git_stash<CR>', 'stash' },
  },

  ['<leader>p'] = {
    name = '+packer',
    d = { '<cmd>PackerClean<CR>', 'clean' },
    c = { '<cmd>PackerCompile<CR>', 'compile' },
    i = { '<cmd>PackerInstall<CR>', 'install' },
    s = { '<cmd>PackerSync<CR>', 'sync' },
    u = { '<cmd>PackerUpdate<CR>', 'update' },
  },

  ['<leader>t'] = {
    name = '+terminal',
    l = { '<cmd>lua require("configs.toggleterm").toggle("lazygit")<CR>', 'lazygit' },
  },

  ['<leader>h'] = {
    name = '+gitsigns',
    s = 'stage hunk',
    S = 'stage buffer',
    u = 'undo stage hunk',
    U = 'reset buffer index',
    r = 'reset hunk',
    R = 'rest buffer',
    p = 'preview hunk',
    b = 'blame line',
  },

  ['<leader>x'] = {
    name = '+leetcode',
    a = {
      '<cmd>lua require("configs.toggleterm").exec("leetcode show " .. vim.fn.expand("%:r:r") .. " --solution")<CR>',
      'solution',
    },
    s = { '<cmd>lua require("configs.toggleterm").exec("leetcode show " .. vim.fn.expand("%:r:r"))<CR>', 'show' },
    S = { '<cmd>lua require("configs.toggleterm").exec("leetcode submit " .. vim.fn.expand("%"))<CR>', 'submit' },
    t = {
      '<cmd>lua require("configs.toggleterm").exec("leetcode test " .. vim.fn.expand("%") .. " --local")<CR>',
      'local test',
    },
    T = { '<cmd>lua require("configs.toggleterm").exec("leetcode test " .. vim.fn.expand("%"))<CR>', 'test' },
  },

  ['<leader>u'] = { '<cmd>lua require("functions").openURL()<CR>', 'open url' },
}
