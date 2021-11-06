require('project_nvim').setup {
  detection_methods = { 'pattern', 'lsp' },

  patterns = { '>codechef', '>codeforces', '>atcoder' },

  ignore_lsp = { 'null-ls', 'html' },

  -- silent_chdir = false,
}
