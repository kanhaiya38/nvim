local M = {}

---@alias keymap.opts { silent: boolean, noremap: boolean, buffer: number, nowait: boolean, expr: boolean }
---@alias mode_letter 'n' | 'v' | 'i' | 't' | 'o' | 'x'
---@alias keymap.mode mode_letter[] | mode_letter
---@alias keymap.mappings table<string, {[1]: function | string, [2]: string, mode: keymap.mode, opts: keymap.opts }>

--- @type keymap.opts
local default_opts = { noremap = true, silent = true }

---@param keymaps { mappings: keymap.mappings, opts: keymap.opts, mode: keymap.mode, debug: boolean }
M.set_keymaps = function(keymaps)
  local mappings = keymaps.mappings
  local opts = keymaps.opts or {}
  local mode = keymaps.mode or 'n'
  local debug = keymaps.debug or false

  for key, val in pairs(mappings) do
    local lhs = key
    local rhs = val[1]
    local desc = val[2]
    local local_mode = val.mode or mode
    local local_opts = vim.tbl_deep_extend('force', default_opts, opts, val.opts or {}, { desc = desc })
    if debug then
      vim.pretty_print('mode', local_mode)
      vim.pretty_print('lhs', lhs)
      vim.pretty_print('rhs', rhs)
      vim.pretty_print('opts', local_opts)
    end
    vim.keymap.set(local_mode, lhs, rhs, local_opts)
  end
end

M.on_save = function(cmd)
  vim.validate({ cmd = { cmd, 'string' } })
  vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'on save',
    callback = function()
      -- require('toggleterm').exec(cmd, 9, nil, nil, nil, nil, nil)
      local term = require('utils.toggleterm').exec
      if not term:is_open() then
        term:open()
      else
        term:send(vim.api.nvim_replace_termcodes('<C-c>', true, true, true))
      end
      term:send(cmd)
      -- term:toggle()
    end,
  })
end

return M
