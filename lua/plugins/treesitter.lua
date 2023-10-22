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

local playground = {
  enable = true,
  disable = {},
  updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  persist_queries = false, -- Whether the query persists across vim sessions
  keybindings = {
    toggle_query_editor = 'o',
    toggle_hl_groups = 'i',
    toggle_injected_languages = 't',
    toggle_anonymous_nodes = 'a',
    toggle_language_display = 'I',
    focus_language = 'f',
    unfocus_language = 'F',
    update = 'R',
    goto_node = '<cr>',
    show_help = '?',
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
        textobjects = textobjects,
        playground = playground,
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
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      { 'nvim-treesitter/playground' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('treesitter-context').setup({
        max_lines = 5,
        -- min_window_height = 30,
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
      })
    end,
  },
  {
    'Wansmer/treesj',
    keys = require('keymaps').treesj,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    lazy = false,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
        blacklist = { 'c', 'cpp' },
      }
    end,
  },
}

return plugins
