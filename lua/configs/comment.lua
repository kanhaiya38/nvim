local contains = function(list, value)
  for _, v in pairs(list) do
    if v == value then
      return true
    end
  end
end

require('Comment').setup {
  pre_hook = function(ctx)
    local fts = { 'typescriptreact', 'typescript', 'javascriptreact', 'javascript' }
    -- Only calculate commentstring for tsx filetypes
    if contains(fts, vim.bo.filetype) then
      local U = require 'Comment.utils'

      -- Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring {
        key = type,
        location = location,
      }
    end
  end,
}
