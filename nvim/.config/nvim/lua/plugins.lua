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
  use "EdenEast/nightfox.nvim"
  -- status line
  use 'freddiehaddad/feline.nvim'
  -- tab line
  use 'nanozuki/tabby.nvim'
  -- lang server protcol
  use 'neovim/nvim-lspconfig'
  -- hook up none lsps with a general purpose lsp
  use {
     'jose-elias-alvarez/null-ls.nvim',
     requires = { 'nvim-lua/plenary.nvim' },
  }
  -- editor config
  use 'editorconfig/editorconfig-vim'
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
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- spell checker
  use {
    'lewis6991/spellsitter.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
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
  use 'jbyuki/instant.nvim'
  -- toggle term
  use { 'akinsho/toggleterm.nvim' }
  --rainbow brackets uwu
  use { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter' } }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
