vim.loader.enable()
require 'keybindings'
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup("plugins")
require 'config'
require 'utils'
require 'treesitter'
require 'toggleterm-config'
vim.cmd('colorscheme carbonfox')
require 'user.ui.feline'
require 'statusline'
require 'nvimtree'
vim.cmd [[
    autocmd FileType 'gitcommit' | NvimTreeClse | endif
    let mapleader="\<SPACE>"
    syntax enable
]]
