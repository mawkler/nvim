----------------------
-- Indent blankline --
----------------------
return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    char = '▏',
    show_first_indent_level = false,
    buftype_exclude = { 'fzf', 'help', 'terminal', 'nofile' },
    filetype_exclude = require('configs.indent-blankline.config').disabled_filetypes
  }
}
