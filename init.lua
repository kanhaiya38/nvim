local status_ok, impatient = pcall(require, 'impatient')
if status_ok then
  impatient.enable_profile()
end
require('settings')
require('keymaps').defaults()
require('plugins')
-- require 'packer_compiled'
