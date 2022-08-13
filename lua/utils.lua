local M = {}

---@alias keymap.opts { silent: boolean, noremap: boolean, buffer: number, nowait: boolean, expr: boolean }
---@alias mode_letter 'n' | 'v' | 't' | 'o' | 'x'
---@alias keymap.mode mode_letter[] | mode_letter
---@alias keymap.mappings table<string, {[1]: funcref, [2]: string, mode: keymap.mode, opts: keymap.opts }>

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
    local local_opts = vim.tbl_deep_extend('force', opts, val.opts or {}, { desc = desc })
    if debug then
      vim.pretty_print('mode', local_mode)
      vim.pretty_print('lhs', lhs)
      vim.pretty_print('rhs', rhs)
      vim.pretty_print('opts', local_opts)
    end
    vim.keymap.set(local_mode, lhs, rhs, local_opts)
  end
end

return M
