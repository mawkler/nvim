return { 'famiu/feline.nvim',
  requires = {
    'SmiteshP/nvim-gps',
    'nvim-lua/lsp-status.nvim',
    'ful1e5/onedark.nvim'
  },
  config = function()
    local colors = require('onedark.colors').setup()
    require('../statusline').setup({
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
      }
    })
    vim.opt.laststatus = 3 -- Global statusline
  end
}
