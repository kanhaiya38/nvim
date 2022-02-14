local expand = vim.fn.expand

require('yabs'):setup {
  languages = { -- List of languages in vim's `filetype` format
    markdown = {
      default_task = 'build_and_run',
      tasks = {
        build = {
          command = 'pandoc % -o ' .. expand '%:r' .. '.pdf',
        },
        run = {
          command = 'xdg-open ' .. expand '%:r' .. '.pdf',
        },
        build_and_run = {
          command = 'pandoc % -o ' .. expand '%:r' .. '.pdf && xdg-open ' .. expand '%:r' .. '.pdf', -- not returning back to vim
        },
      },
    },
  },
}
