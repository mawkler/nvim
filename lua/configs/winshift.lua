--------------
-- Winshift --
--------------
local map = require('utils').map

local function winshift(arg)
  return function()
    require('winshift').cmd_winshift(arg)
  end
end

map('n', '<C-w><C-m>', winshift(),       'Move window')
map('n', '<C-w>m',     winshift(),       'Move window')
map('n', '<C-w><C-x>', winshift('swap'), 'Swap window')
map('n', '<C-w>x',     winshift('swap'), 'Swap window')
map('n', '<C-w>M',     winshift('swap'), 'Swap window')

map('n', '<C-M-H>', winshift('left'),  'Move window border to the left')
map('n', '<C-M-J>', winshift('down'),  'Move window border down')
map('n', '<C-M-K>', winshift('up'),    'Move window border up')
map('n', '<C-M-L>', winshift('right'), 'Move window border to the right')

return {
  'sindrets/winshift.nvim',
  lazy = true,
  config = function()
    require('winshift').setup {
      window_picker = function()
        return require('winshift.lib').pick_window({
          filter_rules = {
            filetype = { 'NvimTree' },
            buftype = { 'terminal', 'quickfix' }
          },
        })
      end,
    }
  end
}
