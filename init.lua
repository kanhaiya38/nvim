local status_ok, impatient = pcall(require, 'impatient')
if status_ok then
  impatient.enable_profile()
end
require('settings').setup()
require('keymaps').defaults()
require('plugins').setup()
-- require 'packer_compiled'
