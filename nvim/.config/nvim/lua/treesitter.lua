require('nvim-treesitter.configs').setup {
  ensure_installed = { 'rust', 'python', 'lua' },
  highlight = {
    enable = true,
    disable = { 'javascript' },
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    colors = {
      '#BF616A',
      '#a89984',
      '#b16286',
      '#EBCB8B',
      '#A3BE8C',
      '#D08770',
      '#88C0D0',
    },
  },
}
