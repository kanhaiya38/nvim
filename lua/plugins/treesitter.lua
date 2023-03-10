local highlight = {
  enable = true, -- false will disable the whole extension
  disable = {}, -- list of language that will be disabled
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,
}

local incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = '<CR>',
    node_incremental = '<CR>',
    scope_incremental = '<Tab>',
    node_decremental = '<S-Tab>',
  },
}

local context_commentstring = {
  enable = true,
  enable_autocmd = false,
}

local rainbow = {
  enable = true,
  hlgroups = {
    'rainbowcol1',
    'rainbowcol2',
    'rainbowcol3',
    'rainbowcol4',
    'rainbowcol5',
    'rainbowcol6',
    'rainbowcol7',
  },
}

local textobjects = {
  select = {
    enable = true,

    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ['gs'] = '@parameter.inner',
    },
    swap_previous = {
      ['gS'] = '@parameter.inner',
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']m'] = '@function.outer',
      [']]'] = '@class.outer',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
      [']['] = '@class.outer',
    },
    goto_previous_start = {
      ['[m'] = '@function.outer',
      ['[['] = '@class.outer',
    },
    goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[]'] = '@class.outer',
    },
  },
}

---@type LazySpec
local plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    name = 'treesitter',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ignore_install = {}, -- List of parsers to ignore installing
        -- default
        highlight = highlight,
        incremental_selection = incremental_selection,
        -- plugins
        -- autotag = extensions.autotag,
        context_commentstring = context_commentstring,
        rainbow = rainbow,
        textobjects = textobjects,
      })
    end,
    build = ':TSUpdate',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'HiPhish/nvim-ts-rainbow2' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('treesitter-context').setup()
        end,
      },
    },
  },
}

return plugins
