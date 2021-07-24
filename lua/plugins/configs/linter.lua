require('lint').linters_by_ft = {
  markdown = { 'vale' },
  javascript = { 'eslint' },
  python = { 'flake8', 'mypy' },
  lua = { 'luacheck' },
}
