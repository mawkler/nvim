----------------------
-- Indent blankline --
----------------------
return {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    char = '▏',
    show_first_indent_level = false,
    buftype_exclude = { 'fzf', 'help' },
    filetype_exclude = {
      'markdown',
      'alpha',
      'sagahover',
      'NvimTree',
      'mason',
      'toggleterm',
      'lazy',
    }
  }
}
