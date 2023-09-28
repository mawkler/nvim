----------------------
-- Indent blankline --
----------------------
return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  opts = {
    show_first_indent_level = false,
    indent = { char = '▏' },
    exclude = {
      filetypes = require('configs.indent-blankline.config').disabled_filetypes,
      buftypes = { 'fzf', 'help', 'terminal', 'nofile' },
    },
  }
}
