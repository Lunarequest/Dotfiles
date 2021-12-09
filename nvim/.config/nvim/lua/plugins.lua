-- ensure everything is installed
vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- if packer isn't installing install it
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

return require('packer').startup(function()
  -- packer will manager packer installs
  use 'wbthomason/packer.nvim'
  -- speeed
  use 'lewis6991/impatient.nvim'
  -- nvimtree for that lovely filesystem view
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup {}
    end,
  }
  -- the theme baby
  use 'arcticicestudio/nord-vim'
  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  -- lang server protcol
  use 'neovim/nvim-lspconfig'
  -- colors
  use 'folke/lsp-colors.nvim'
  -- Autocompletion plugin
  use 'hrsh7th/nvim-cmp'
  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'
  -- Snippets source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
  -- fuzzy search
  use 'junegunn/fzf'
  -- git stuff
  use 'airblade/vim-gitgutter'
  -- more git stuff
  use 'tpope/vim-fugitive'
  -- black for python formating
  use { 'psf/black', opt = true }
  -- tree sitter for highlighting
  use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  -- discord stuff
  use 'andweeb/presence.nvim'
  -- spell checker
  use {
    'lewis6991/spellsitter.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat' },
    opt = true,
  }
  -- rust stuff nya
  use {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  }
  -- collaboration
  use 'jbyuki/instant.nvim'
  -- markdown rendering
  use { 'npxbr/glow.nvim', run = 'GlowInstall' }
  -- toggle term
  use { 'akinsho/toggleterm.nvim' }
  --rainbow brackets uwu
  use { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat' } }
  if packer_bootstrap then
    require('packer').sync()
  end
end)