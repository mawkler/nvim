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
    local colors = require('utils.colorscheme').colors
    local get_mode_color = require('utils.colorscheme').get_mode_color

    local onedark_theme = {
      fg = '#c8ccd4',
      middle_bg = colors.bg_sidebar,
      line_bg = '#353b45',
      separator_bg = colors.bg0,
      dark_text = '#9ba1b0',
      git_add = colors.green0,
      git_change = colors.orange0,
      snippet = colors.blue0,
      git_remove = colors.red1,
      select_mode = colors.cyan0,
      hint = colors.dev_icons.gray,
      warning = colors.warning,
      error = colors.error,
      info = colors.info,
      mode = {
        normal = get_mode_color('normal'),
        insert = get_mode_color('insert'),
        command = get_mode_color('command'),
        visual = get_mode_color('visual'),
        replace = get_mode_color('replace'),
        term = get_mode_color('term'),
      },
    }

    require('statusline').setup({
      theme = onedark_theme
    })

    require('feline').add_theme('onedark', onedark_theme)

    vim.opt.laststatus = 3 -- Global statusline
  end
}
