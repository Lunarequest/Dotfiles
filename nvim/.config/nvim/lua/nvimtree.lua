local api = require('nvim-tree.api')

local function open_nvim_tree()
    if vim.bo.filetype ~= 'gitcommit' then
        api.tree.open({
            focus = false
        })
    end
end

vim.api.nvim_create_autocmd({"VimEnter"}, {
    callback = open_nvim_tree
})
