local api = require('nvim-tree.api')

require('nvim-tree').setup {
  diagnostics = {
    enable = true,
  },
  view = {
    width = 30,
    hide_root_folder = true,
    side = 'left',
  },
}

local function open_nvim_tree() 
    api.tree.open({focus = false})
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
