----------------------
-- Indent blankline --
----------------------
require('indent_blankline').setup {
  char = '▏',
  show_first_indent_level = false,
  buftype_exclude = {'fzf', 'help'},
  filetype_exclude = {
    'markdown',
    'startify',
    'sagahover',
    'NvimTree',
    'lsp-installer',
    'toggleterm',
    'packer',
  }
}
