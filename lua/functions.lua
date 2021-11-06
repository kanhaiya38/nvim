local M = {}
local fn = vim.fn

M.openURL = function()
  local url = fn.matchstr(fn.getline '.', '[a-z]*://[^ >,;]*')
  print(url)
  if url ~= '' then
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
  else
    print 'No URL found in line.'
  end
end

return M
