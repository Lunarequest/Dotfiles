-- require 'impatient'
require 'plugins'
require 'config'
require 'utils'
require 'treesitter'
require 'toggleterm-config'
require 'keybindings'
vim.cmd("colorscheme nightfox")
require 'user.ui.feline'
require 'statusline'
require 'nvimtree'

vim.cmd [[
    let mapleader="\<SPACE>"
    syntax enable
]]
