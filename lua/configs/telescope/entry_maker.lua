local Path = require('plenary.path')
local strings = require('plenary.strings')
local utils = require('telescope.utils')
local entry_display = require('telescope.pickers.entry_display')

local M = {}

M.find_files = function(opts)
  opts = opts or {}

  local make_display = function(entry)
    local icon, hl_group = utils.get_devicons(entry.value)
    local icon_width = strings.strdisplaywidth(icon)
    local shortname = vim.fn.fnamemodify(entry.value, ':t')

    local displayer = entry_display.create({
      separator = ' ',
      items = {
        { width = icon_width },
        { width = string.len(shortname) },
        { remaining = true },
      },
    })

    return displayer({
      { icon, hl_group },
      { shortname },
      { entry.filename, 'TelescopeResultsComment' },
    })
  end

  return function(entry)
    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
    local path = Path:new({ cwd, entry }):absolute()
    if not vim.loop.fs_access(path, 'R', nil) then
      path = entry
    end

    return {
      cwd = cwd,
      filename = entry,
      display = make_display,
      ordinal = entry,
      value = entry,
      path = path,
    }
  end
end

return M
