---------------
-- Modicator --
---------------
return { 'melkster/modicator.nvim',
  wants = require('utils.colorscheme').colorscheme_names,
  event = 'ModeChanged',
  config = function()
    local colors = require('utils.colorscheme').modes

    require('modicator').setup({
      show_warnings = false,
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
