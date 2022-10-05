---------------
-- Modicator --
---------------
return { 'melkster/modicator.nvim',
  after = 'onedark.nvim',
  config = function()
    local colors = require('utils.colors').modes

    require('modicator').setup({
      highlights = {
        modes = {
          ['i']  = colors.insert,
          ['v']  = colors.visual,
          ['V']  = colors.visual,
          [''] = colors.visual,
          ['s']  = colors.select,
          ['S']  = colors.select,
          ['R']  = colors.replace,
          ['c']  = colors.command,
        }
      }
    })
  end
}
