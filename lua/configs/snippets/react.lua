local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local use_state = {
  t('const ['),
  i(1, 'state'),
  t(', '),
  f(function(args)
    return 'set' .. args[1][1]:gsub('^%l', string.upper)
  end, { 1 }),
  t('] = useState<'),
  i(2, 'T'),
  t('>('),
  i(0, 'default'),
  t(')'),
}

local ed = {
  t('export default '),
  i(1),
}

local use = {
  t('const '),
  i(0),
  t(' = use'),
  i(1, 'Hook'),
}

ls.add_snippets('typescriptreact', {
  s('uss', use_state),
  s('ed', ed),
  s('use', use),
})
