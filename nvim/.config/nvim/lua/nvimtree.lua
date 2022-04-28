local tree_cb = require('nvim-tree.config').nvim_tree_callback
require('nvim-tree').setup {
  open_on_setup = true,
  diagnostics = {
    enable = true,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = true,
    side = 'left',
  },
}
