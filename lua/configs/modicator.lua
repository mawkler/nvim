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
        defaults = { bold = true },
        modes = {
          ['i']  = { color = colors.insert },
          ['v']  = { color = colors.visual },
          ['V']  = { color = colors.visual },
          [''] = { color = colors.visual },
          ['s']  = { color = colors.select },
          ['S']  = { color = colors.select },
          ['R']  = { color = colors.replace },
          ['c']  = { color = colors.command },
        }
      }
    })
  end
}
