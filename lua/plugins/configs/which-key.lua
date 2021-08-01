require('which-key').setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local wk = require 'which-key'

wk.register {
  ['<leader>a'] = {
    name = '+actions',
    f = { '<cmd>Format<CR>', 'format' },
    g = { '<cmd>Glow<CR>', 'glow' },
  },

  ['<leader>b'] = {
    name = '+buffer',
    c = { '<cmd>BufferClose<CR>', 'close' },
    w = { '<cmd>BufferWipeout<CR>', 'wipe' },
    a = { '<cmd>BufferCloseAllButCurrent<CR>', 'close all but current' },
    r = { '<cmd>BufferCloseBuffersRight<CR>', 'close all buffers right' },
    l = { '<cmd>BufferCloseBuffersLeft<CR>', 'close all buffers left' },
    D = { '<cmd>BufferOrderByDirectory<CR>', 'order by directory' },
    L = { '<cmd>BufferOrderByLanguage<CR>', 'order by language' },
    z = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'buffer fuzzy find' },
    t = { '<cmd>Telescope current_buffer_tags<CR>', 'buffer tags' },
  },

  ['<leader>f'] = {
    name = '+file',
    d = { '<cmd>Telescope find_files<CR>', 'find files' },
    f = { '<cmd>Telescope git_files<CR>', 'git files' },
    s = { '<cmd>Telescope grep_string<CR>', 'grep string' },
    g = { '<cmd>Telescope live_grep<CR>', 'live grep' },
    b = { '<cmd>Telescope file_browser<CR>', 'file browser' },
  },

  ['<leader>s'] = {
    name = '+search',
    b = { '<cmd>Telescope buffers<CR>', 'buffers' },
    h = { '<cmd>Telescope oldfiles<CR>', 'recent files' },
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
    a = { '<cmd>Telescope lsp_code_actions<CR>', 'code actions' },
    A = { '<cmd>Telescope lsp_range_code_actions<CR>', 'range codeactions' },
    d = { '<cmd>Telescope lsp_document_diagnostics<CR>', 'document diagnostic' },
    i = { '<cmd>Telescope lsp_implementations<CR>', 'implementations' },
    D = { '<cmd>Telescope lsp_definitions<CR>', 'definitions' },
  },

  ['<leader>w'] = {
    s = { '<cmd>Telescope lsp_workspace_symbols<CR>', 'workspace symbols' },
    S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'dynamic workspace symbols' },
    d = { '<cmd>Telescope lsp_workspace_diagnostics<CR>', 'workspace diagnostic' },
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
    l = { '<cmd>lua require("plugins.configs.toggleterm").toggle("lazygit")<CR>', 'lazygit' },
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
}
