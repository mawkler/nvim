------------
-- Feline --
------------
return {
  'freddiehaddad/feline.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/lsp-status.nvim',
  },
  config = function()
    local colors = require('utils.colorscheme').colors.feline
    local get_mode_color = require('utils.colorscheme').get_mode_color

    local onedark_theme = {
      fg = '#c8ccd4',
      middle_bg = colors.middle_bg,
      line_bg = '#353b45',
      separator_bg = colors.separator_bg,
      dark_text = '#9ba1b0',
      git_add = colors.git.add,
      git_change = colors.git.change,
      snippet = colors.snippet,
      git_remove = colors.git.delete,
      hint = colors.diagnostics.hint,
      warning = colors.diagnostics.warning,
      error = colors.diagnostics.error,
      info = colors.diagnostics.info,
      normal_mode = get_mode_color('normal'),
      insert_mode = get_mode_color('insert'),
      command_mode = get_mode_color('command'),
      visual_mode = get_mode_color('visual'),
      replace_mode = get_mode_color('replace'),
      term_mode = get_mode_color('term'),
      select_mode = get_mode_color('select'),
    }

    require('statusline').setup({ theme = onedark_theme })
    require('feline').add_theme('onedark', onedark_theme)

    vim.opt.laststatus = 3 -- Global statusline
  end
}
