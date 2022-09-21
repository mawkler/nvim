----------------------
-- Indent blankline --
----------------------
return { 'lukas-reineke/indent-blankline.nvim',
  config = function()
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('indent_blankline',  {
      char = '▏',
      show_first_indent_level = false,
      buftype_exclude = {'fzf', 'help'},
      filetype_exclude = {
        'markdown',
        'startify',
        'alpha',
        'sagahover',
        'NvimTree',
        'lsp-installer',
        'toggleterm',
        'packer',
      }
    })
  end
}
