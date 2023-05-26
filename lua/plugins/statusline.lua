local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = function()
  -- Eviline config for lualine
  -- Author: shadmansaleh
  -- Credit: glepnir
  local colors = require('onedark.colors')
  local icons = require('icons')
  -- Config
  local separator1 = {
    function()
      return icons.misc.Separator
    end,
    color = { fg = colors.blue }, -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
  }
  local mode = {
    -- mode component
    function()
      return ''
    end,
    color = function()
      -- auto change color according to neovims mode
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.purple,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
  }

  local filename = {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.purple, gui = 'bold' },
  }
  local location = { 'location' }
  local file_progress = { 'progress', color = { fg = colors.fg, gui = 'bold' } }
  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = icons.diagnostic.Error,
      warn = icons.diagnostic.Warning,
      info = icons.diagnostic.Info,
    },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  }

  local lsp = {
    function()
      local msg = 'No Active Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end,
    icon = icons.misc.Lsp,
    color = { fg = colors.fg, gui = 'bold' },
  }
  local git = {
    'branch',
    icon = icons.git.Branch,
    color = { fg = colors.cyan, gui = 'bold' },
  }
  local diff = {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = {
      added = icons.git.GitAdded,
      modified = icons.git.GitModified,
      removed = icons.git.GitRemoved,
    },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  }
  local separator2 = {
    function()
      return icons.misc.Separator
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
  }

  local opts = {
    options = {
      -- Disable sections and component separators
      component_separators = '',
      section_separators = '',
      globalstatus = true, -- enable global statusline (have a single statusline
      theme = 'onedark',
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {
        separator1,
        mode,
        git,
        diff,
      },
      lualine_x = {
        lsp,
        {
          function()
            return '%='
          end,
        },
        diagnostics,
        filename,
        location,
        file_progress,
        separator2,
      },
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  require('lualine').setup(opts)
end

---@type LazySpec
local plugins = {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = config,
  },
}

return plugins
