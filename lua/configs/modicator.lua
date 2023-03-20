---------------
-- Modicator --
---------------
return { 'mawkler/modicator.nvim',
  -- wants = require('utils.colorscheme').colorscheme_names,
  event = 'ModeChanged',
  config = function()
    local get_mode_color = require('utils.colorscheme').get_mode_color
    local get_bg = require('modicator').get_highlight_bg

    local visual_hl = {
      foreground = get_mode_color('visual'),
      background = get_bg('Normal') -- Removes background
    }

    require('modicator').setup({
      show_warnings = false,
      highlights = {
        defaults = { bold = true },
        modes = {
          ['i']  = { foreground = get_mode_color('insert') },
          ['s']  = { foreground = get_mode_color('select') },
          ['S']  = { foreground = get_mode_color('select') },
          ['R']  = { foreground = get_mode_color('replace') },
          ['c']  = { foreground = get_mode_color('command') },
          ['v']  = visual_hl,
          ['V']  = visual_hl,
          [''] = visual_hl,
        },
      },
    })
  end
}
