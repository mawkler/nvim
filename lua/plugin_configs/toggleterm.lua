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

