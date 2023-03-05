local o = vim.opt -- vim.opt acts like :set
local g = vim.g -- this behaves like set g:
local cmd = vim.cmd -- for running vim commands
local u = require 'utils'
local nvim_lsp = require 'lspconfig'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local fn = vim.fn
local null_ls = require("null-ls")

-- set line number
o.number = true
-- set tab = 4 columns
o.tabstop = 4
-- folding foldable things
o.foldenable = true
o.foldtext = 'gitgutter#fold#foldtext()'
-- fold based on indents duh
o.foldmethod = 'indent'
-- match brackets
o.showmatch = true
-- more tab stuff
o.shiftwidth = 4
o.expandtab = true
-- make encoding UTF-8
o.encoding = 'UTF-8'
-- indent based on files
o.smartindent = true
-- toggle term
o.hidden = true

-- if the terminal has "true colors" use them
if fn.has 'termguicolors' == 1 then
  o.termguicolors = true
end

-- aurgroup/autocmd hasn't been implemented yet :(
u.create_augroup({
  { 'FileType', 'python', 'packadd', 'black' },
  { 'FileType', 'markdown', 'packadd', 'spellsitter.nvim' },
}, 'autoloadfiletypes')

-- spellsitter
if vim.bo.filetype == markdown then
  o.wrap = true
  require('spellsitter').setup {
    enable = true,
    hl = 'SpellBad',
    captures = {
      'comment',
      'text',
    },
  }
end

-- gitgutter configs
g.gitgutter_sign_added = '+'
g.gitgutter_sign_modified = '>'
g.gitgutter_sign_removed = '-'
g.gitgutter_sign_removed_first_line = '^'
g.gitgutter_sign_modified_removed = '<'
g.gitgutter_override_sign_column_highlight = 1
g.gitgutter_highlight_linenrs = 1
o.updatetime = 250 -- make git gutter seem more responsive

-- glow
g.glow_broder = 'rounded'

-- everforest
g.everforest_background = 'soft'
g.everforest_better_performance = 1

-- sign config lsp
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

-- custom signs for lsp
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lsp show issues on hover
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- nvim cmp
capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'bashls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- null-ls setup
null_ls.setup({
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.black,
    null_ls.builtins.hover.dictionary,
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
              augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
              augroup END  
            ]])
        end
    end,
})

vim.o.completeopt = 'menuone,noselect'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- lazy load crates as nvim cmp source if file type is toml
vim.cmd [[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]
