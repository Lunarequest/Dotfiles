require 'impatient'
require 'plugins'
require 'config'
require 'utils'
require 'treesitter'
require 'toggleterm-config'
require 'discord'
require 'keybindings'
require 'statusline'
require 'nvimtree'

vim.cmd [[
    syntax enable
    colorscheme nord
    autocmd BufRead * silent! NvimTreeToggle
]]
