local ls = require('luasnip')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local i = ls.insert_node
local l = require('luasnip.extras').lambda

local const_filename = {
  t('const '),
  l(l.TM_FILENAME:match('(.*)%..*'), {}),
  t(' '),
}

local use_state = {
  t('const ['),
  i(1, 'state'),
  t(', '),
  f(function(args)
    return 'set' .. args[1][1]:gsub('^%l', string.upper)
  end, { 1 }),
  t('] = useState'),
  d(3, function(args)
    if args[1][1] ~= '' then
      print('equal')
      return sn(nil, {})
    end
    return sn(nil, {
      -- jump-indices are local to each snippetNode, so restart at 1.
      t('<'),
      i(1, 'T'),
      t('>'),
    })
  end, { 2 }),
  t('('),
  i(2),
  t(')'),
}

local react_component = {
  t('export const '),
  i(1, 'Component'),
  t({
    ' = () => {',
    '\treturn ',
  }),
  i(0, '<></>'),
  t({ '', '};' }),
}

local react_component_props = {
  t('interface '),
  f(function(args)
    return args[1][1] .. 'Props'
  end, { 1 }),
  t({ ' {', '\t' }),
  i(2, 'props'),
  t({ '', '};', '', 'export const ' }),
  i(1, 'Component'),
  t(': React.FC<'),
  f(function(args)
    return args[1][1] .. 'Props'
  end, { 1 }),
  t('> = ('),
  t(') => {', '', '\treturn '),
  i(0, '<></>'),
  t({ '', '};' }),
}

return {
  s('cf', const_filename),
  s('uss', use_state),
  s('rc', react_component),
  s('rcp', react_component_props),
}
