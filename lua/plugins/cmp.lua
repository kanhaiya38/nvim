local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local entry_format = function(entry, vim_item)
  return require('lspkind').cmp_format({
    mode = 'symbol',
    maxwidth = 50,
    before = require('tailwind-tools.cmp').lspkind_format,
    menu = {
      buffer = '[Buffer]',
      nvim_lsp = '[LSP]',
      luasnip = '[LuaSnip]',
      nvim_lua = '[Lua]',
      latex_symbols = '[Latex]',
    },
  })(entry, vim_item)
end

local config = function()
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
      { name = 'copilot' },
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
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(tab_complete, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(s_tab_complete, { 'i', 's' }),
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = entry_format,
    },
    -- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#comparators
    sorting = {
      priority_weight = 2,
      comparators = {
        require('copilot_cmp.comparators').prioritize,

        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
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

---@type LazySpec
local plugins = {
  {
    'hrsh7th/nvim-cmp',
    name = 'cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = config,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind-nvim',
      'luckasRanarison/tailwind-tools.nvim',
    },
  },
  {
    'onsails/lspkind-nvim',
    config = function()
      local lspkind = require('lspkind')
      lspkind.init({
        symbol_map = {
          Copilot = '',
        },
      })

      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    end,
  },
}

return plugins
