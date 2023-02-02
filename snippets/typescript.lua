local export_default_as = {
  t('export { default as '),
  l(l._1, { 1 }),
  t(" } from './"),
  i(1, ''),
  t("';"),
}

return {
  s('eda', export_default_as),
}
