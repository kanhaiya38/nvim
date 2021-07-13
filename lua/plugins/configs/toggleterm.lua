vim.o.hidden = true -- otherwise terminal will be discarded when closed

require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  shade_terminals = true,
  shading_factor = 0.6,
}
