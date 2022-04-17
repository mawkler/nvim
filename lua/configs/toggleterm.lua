----------------
-- Toggleterm --
----------------
return { 'akinsho/toggleterm.nvim',
  keys = '<C-CR>',
  config = function()
    require('toggleterm').setup {
      open_mapping = '<C-CR>',
      direction = 'float',
      float_opts = {
        border = 'curved',
        winblend = 4,
        highlights = {
          background = 'NormalFloat',
          border = 'TelescopeBorder',
        },
      },
    }
  end
}
