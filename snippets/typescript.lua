local export_default_as = {
  t('export { default as '),
  l(l._1, { 1 }),
  t(" } from './"),
  i(1, ''),
  t("';"),
}

local export_all_as = {
  t('export * as '),
  l(l._1, { 1 }),
  t(" from './"),
  i(1, ''),
  t("'"),
}

local import_all_as = {
  t('import * as '),
  l(l._1:gsub('%.%./', ''):gsub('^%./', ''):gsub('^@', ''), { 1 }),
  t(" from '"),
  i(1, ''),
  t("'"),
}

local export_all_from = {
  t("export * from './"),
  i(1, ''),
  t("'"),
}

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

local af = {
  t('async function '),
  i(1, 'name'),
  t('(params: '),
  i(2, 'params'),
  t('): Promise<'),
  i(3, 'return'),
  t('> {'),
  i(0),
  t('}'),
}

return {
  s('eda', export_default_as),
  s('eas', export_all_as),
  s('eaf', export_all_from),
  s('ias', import_all_as),
  s('clo', console_log),
  s('here', here),
  s('af', af),
}
