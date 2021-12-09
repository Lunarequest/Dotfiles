local map = vim.api.nvim_set_keymap

map('n', '<C-g>', ':GitGutterNextHunk<CR>', { noremap = true })
map('n', '<C-a>', ':NvimTreeToggle<CR>', { noremap = true })
map('n', '<A-g>', ':Glow<CR>', { noremap = true })
