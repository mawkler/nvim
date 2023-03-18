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

    require('feline').add_theme('onedark', colors)

    require('statusline').setup({
      theme = {
        fg = '#c8ccd4',
        middle_bg = colors.bg_sidebar,
        line_bg = '#353b45',
        separator_bg = colors.bg0,
        dark_text = '#9ba1b0',
        git_add = colors.green0,
        git_change = colors.orange0,
        snippet = colors.blue0,
        purple = colors.purple0,
        red = colors.red0,
        select_mode = colors.cyan0,
        hint = colors.dev_icons.gray,
        shell_mode = colors.green0,
        enter_mode = colors.orange0,
        more_mode = colors.orange0,
        none_mode = colors.line_bg,

        -- normal_mode =
      }
    })

    vim.opt.laststatus = 3 -- Global statusline
  end
}
