-- vim: ft=lua

stds.nvim = {
  globals = { 'O', vim = { fields = { 'g' } } },
  read_globals = {
    'jit',
    'vim',
  },
}

std = 'lua51+nvim'

ignore = {
  '631', -- max_line_length
  '212/_.*', -- unused argument, for vars with "_" prefix
}

-- Rerun tests only if their modification time changed.
cache = true
