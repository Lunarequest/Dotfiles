require('nvim-treesitter.configs').setup {
  ensure_installed = { 'rust', 'python', 'lua', 'yaml', 'json', 'javascript', 'typescript', 'tsx' },
  highlight = {
    enable = true,
    disable = { 'javascript' },
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    strategy = require('ts-rainbow').strategy.global,
  },
}
