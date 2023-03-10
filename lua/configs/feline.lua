------------
-- Feline --
------------
return { 'freddiehaddad/feline.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/lsp-status.nvim',
  },
  config = function()
      -- TODO: refactor this to do both imports on same line once
      -- https://github.com/miversen33/import.nvim/issues/11 gets merged
    local colorscheme = require('utils.colorscheme')
    local colors = colorscheme.colors

    require('statusline').setup({
      theme = colors,
      modifications = {
        bg = colors.bg_sidebar,
        fg = '#c8ccd4',
        line_bg = '#353b45',
        darkgray = '#9ba1b0',
        green = colors.green0,
        blue = colors.blue0,
        orange = colors.orange0,
        purple = colors.purple0,
        red = colors.red0,
        cyan = colors.cyan0,
        hint = colors.dev_icons.gray,
      }
    })

    vim.opt.laststatus = 3 -- Global statusline
  end
}
