local export_default_as = {
  t('export { default as '),
  l(l._1, { 1 }),
  t(" } from './"),
  i(1, ''),
  t("';"),
}

local console_log = {
  t("console.log('"),
  l(l._1, { 1 }),
  t("', "),
  i(1, 'val'),
  t(');'),
}

return {
  s('eda', export_default_as),
  s('clo', console_log),
}
