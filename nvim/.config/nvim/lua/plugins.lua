return { -- nvimtree for that lovely filesystem view
{
    'kyazdani42/nvim-tree.lua',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('nvim-tree').setup {}
    end
}, -- the theme baby
{
    "EdenEast/nightfox.nvim",
    lazy = true
}, -- status line
{
    'freddiehaddad/feline.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons'}
}, -- tab line
'nanozuki/tabby.nvim', -- lang server protcol
'neovim/nvim-lspconfig', 'simrat39/inlay-hints.nvim', -- hook up none lsps with a general purpose lsp
{
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {'nvim-lua/plenary.nvim'}
}, -- editor config
'editorconfig/editorconfig-vim', -- Autocompletion plugin
'hrsh7th/nvim-cmp', -- LSP source for nvim-cmp
'hrsh7th/cmp-nvim-lsp', -- Snippets source for nvim-cmp
'saadparwaiz1/cmp_luasnip', -- Snippets plugin
'L3MON4D3/LuaSnip', -- fuzzy search
'junegunn/fzf', -- git stuff
'lewis6991/gitsigns.nvim', -- more git stuff
'tpope/vim-fugitive', -- black for python formating
{
    'psf/black',
    enabled = false
}, -- tree sitter for highlighting
{
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}, {
    "cloudsftp/peek.nvim",
    branch="bundle",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        -- refer to `configuration to change defaults`
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
}, 
-- rust stuff nya
{
    'Saecki/crates.nvim',
    event = {'BufRead Cargo.toml'},
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require('crates').setup()
    end
}, -- toggle term
{'akinsho/toggleterm.nvim'}, -- rainbow brackets uwu
{
    'HiPhish/nvim-ts-rainbow2',
    dependencies = {'nvim-treesitter/nvim-treesitter'}
}}
