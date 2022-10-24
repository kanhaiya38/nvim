local M = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local entry_format = function(entry, vim_item)
  return require('lspkind').cmp_format({
    mode = 'symbol',
    maxwidth = 50,
    menu = {
      buffer = '[Buffer]',
      nvim_lsp = '[LSP]',
      luasnip = '[LuaSnip]',
      nvim_lua = '[Lua]',
      latex_symbols = '[Latex]',
    },
  })(entry, vim_item)
end

M.setup = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  -- Use (s-)tab to:
  -- move to prev/next item in completion menuone
  -- jump to prev/next snippet's placeholder
  local tab_complete = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local s_tab_complete = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  cmp.setup({
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
    }, {
      { name = 'path' },
      { name = 'buffer' },
      { name = 'calc' },
      { name = 'emoji' },
      -- TODO: neorg
    }),
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(tab_complete, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(s_tab_complete, {
        'i',
        's',
      }),
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = entry_format,
    },
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
    }, {
      { name = 'buffer' },
    }),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
