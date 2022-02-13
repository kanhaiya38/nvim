local spiderman_header = {
  [[⠀⠀⠀⡐⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⢂⠀⠀⠀]],
  [[⠀⠀⣰⠀⡸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠈⢆⠀⠀]],
  [[⠀⢠⡇⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⢸⡄⠀]],
  [[⠀⣼⠀⠘⠗⢒⣒⡲⣄⣀⣠⣠⢒⣒⡒⠺⠃⠈⣧⠀]],
  [[⠀⠻⠶⠚⠉⣩⡭⢭⣿⣿⣿⣿⠭⢭⣍⠉⠓⠶⠟⠀]],
  [[⠀⠀⢀⡤⠚⢡⣴⠋⣽⣿⣿⣯⠙⣦⡌⠳⢄⡀⠀⠀]],
  [[⣤⡶⠋⠀⠀⢸⣿⠀⢸⣿⣿⡇⠀⣿⡇⠀⠀⠙⢶⣤]],
  [[⣿⠀⠀⠀⠀⢸⣿⠀⠈⣿⣿⠁⠀⣿⡇⠀⠀⠀⠀⣿]],
  [[⢹⡄⠀⠀⠀⠀⣿⠀⠀⠘⠃⠀⠀⣿⠁⠀⠀⠀⢠⡏]],
  [[⠈⡇⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢸⠁]],
  [[⠀⠘⡀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⡏⠀⠀⠀⢀⠃⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀⠀⠀⠸⠁⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠘⠄⠀⠀⠠⠃⠀⠀⠀⠀⠀⠀⠀]],
}

local settings = {
  -- every line should be same width without escaped \
  header = {
    type = 'text',
    align = 'center',
    fold_section = false,
    title = 'Header',
    content = spiderman_header,
    highlight = 'DashboardHeader',
  },

  body = {
    type = 'mapping',
    align = 'center',
    fold_section = false,
    title = 'Basic Commands',
    content = {
      { ' Find File', 'Telescope find_files', 'f' },
      { ' Find Word', 'Telescope live_grep', 'g' },
      { ' Recent Files', 'Telescope oldfiles', 'h' },
      { ' File Browser', 'Telescope file_browser', 'b' },
      { ' Colorschemes', 'Telescope colorscheme', 'c' },
      { ' New File', "lua require'startup'.new_file()", 'n' },
    },
    highlight = 'DashboardCenter',
  },

  footer = {
    type = 'text',
    content = require('startup.functions').packer_plugins(),
    align = 'center',
    fold_section = false,
    title = '',
    highlight = 'DashboardFooter',
  },

  options = {
    mapping_keys = true,
    cursor_column = 0.5,
    empty_lines_between_mappings = true,
    disable_statuslines = true,
    paddings = { 2, 2, 2 },
  },
  parts = {
    'header',
    'body',
    'footer',
  },
}

require('startup').setup(settings)
