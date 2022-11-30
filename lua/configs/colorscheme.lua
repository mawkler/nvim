local colors = require('onedark').get_colors()

return {
  colors = colors,
  modes = {
    normal  = colors.green0,
    insert  = colors.blue0,
    visual  = colors.purple0,
    command = colors.red0,
    select  = colors.cyan0,
    replace = colors.red2,
    term    = colors.green0,
  },
   -- Names of all colorschemes, to be used by Packer's `after`
  colorscheme_names = { 'onedark.nvim' }
}
