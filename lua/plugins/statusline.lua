local config = function()
  local colors = require('onedark.colors')
  local icons = require('icons')

  local separator1 = {
    function()
      return icons.misc.Separator
    end,
    color = { fg = colors.blue },
    padding = { left = 0, right = 1 },
  }
  local mode = {
    function()
      return ''
    end,
    color = function()
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

  local file_progress = { 'progress' }
  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = icons.diagnostic.Error,
      warn = icons.diagnostic.Warn,
      info = icons.diagnostic.Info,
    },
  }

  local lsp = {
    function()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if buf_clients == 0 then
        return 'LSP Inactive'
      end

      local buf_client_names = {}
      for _, client in pairs(buf_clients) do
        if client.name ~= 'null-ls' then
          table.insert(buf_client_names, client.name)
        end
      end

      return table.concat(buf_client_names, ', ')
    end,
    icon = icons.misc.Lsp,
    color = { fg = colors.blue },
  }
  local git = {
    'b:gitsigns_head',
    icon = icons.git.Branch,
    color = { fg = colors.cyan },
  }
  local diff = {
    'diff',
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
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
  }
  local separator2 = {
    function()
      return icons.misc.Separator
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
  }
  local updates = {
    require('lazy.status').updates,
    cond = require('lazy.status').has_updates,
    color = { fg = '#ff9e64' },
  }

  local opts = {
    options = {
      component_separators = '',
      section_separators = '',
      globalstatus = true,
      theme = {
        inactive = {
          a = { fg = colors.gray, bg = colors.bg, gui = 'bold' },
          b = { fg = colors.gray, bg = colors.bg },
          c = { fg = colors.gray, bg = colors.bg1 },
        },
        normal = {
          a = { fg = colors.fg, bg = colors.bg_statusline },
          b = { fg = colors.fg, bg = colors.bg_statusline },
          c = { fg = colors.fg, bg = colors.bg_statusline },
        },
      },
    },
    sections = {
      lualine_a = { separator1 },
      lualine_b = { mode },
      lualine_c = { git, diff },
      lualine_x = { diagnostics, lsp },
      lualine_y = { updates, file_progress },
      lualine_z = { separator2 },
    },
    inactive_sections = {
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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = config,
  },
}

return plugins
