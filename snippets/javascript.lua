local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local l = require('luasnip.extras').lambda

local console_log = {
  t("console.log('"),
  l(l._1, { 1 }),
  t("', "),
  i(1, 'val'),
  t(');'),
}

local here = {
  t("console.log('here');"),
}

return {
  s('clo', console_log),
  s('here', here),
}
