local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Use (s-)tab to:
-- move to prev/next item in completion menuone
-- jump to prev/next snippet's placeholder
local tab_complete = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(t '<Plug>luasnip-expand-or-jump', '')
  elseif check_back_space() then
    vim.fn.feedkeys(t '<Tab>', 'n')
  else
    fallback()
  end
end

local s_tab_complete = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(t '<Plug>luasnip-jump-prev', '')
  else
    fallback()
  end
end

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'emoji' },
    -- TODO: neorg
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(tab_complete, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(s_tab_complete, {
      'i',
      's',
    }),
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = '[LSP]',
        buffer = '[Buffer]',
        luasnip = '[LuaSnip]',
        path = '[Path]',
        calc = '[Calc]',
        emoji = '[Emoji]',
      },
    },
  },
}
