---------------
-- Modicator --
---------------
return { 'mawkler/modicator.nvim',
  wants = require('utils.colorscheme').colorscheme_names,
  event = 'ModeChanged',
  config = function()
    local colors = require('utils.colorscheme').modes
    local get_bg = require('modicator').get_highlight_bg

    local visual_hl = {
      foreground = colors.visual,
      background = get_bg('Normal') -- Removes background
    }

    require('modicator').setup({
      show_warnings = false,
      highlights = {
        defaults = { bold = true },
        modes = {
          ['i']  = { foreground = colors.insert },
          ['s']  = { foreground = colors.select },
          ['S']  = { foreground = colors.select },
          ['R']  = { foreground = colors.replace },
          ['c']  = { foreground = colors.command },
          ['v']  = visual_hl,
          ['V']  = visual_hl,
          [''] = visual_hl,
        }
      }
    })
  end
}
