require 'impatient'
require 'plugins'
require 'config'
require 'utils'
require 'treesitter'
require 'toggleterm-config'
require 'discord'
require 'keybindings'
require 'statusline'
require 'theme_config'
require 'nvimtree'

vim.cmd [[
    syntax enable
    colorscheme catppuccin
    autocmd BufRead * silent! NvimTreeToggle
]]
