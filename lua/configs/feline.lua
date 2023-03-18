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
    local modes = require('utils.colorscheme').modes

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
        normal = modes.normal,
        insert = modes.insert,
        command = modes.command,
        visual = modes.visual,
        replace = modes.replace,
        term = modes.term,
      },
    }

    require('statusline').setup({
      theme = onedark_theme
    })

    require('feline').add_theme('onedark', onedark_theme)

    vim.opt.laststatus = 3 -- Global statusline
  end
}
