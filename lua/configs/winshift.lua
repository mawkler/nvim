--------------
-- Winshift --
--------------
local map = require('utils').map

local function winshift(arg)
  return function()
    require('winshift').cmd_winshift(arg)
  end
end

map('n', '<C-w><C-m>', winshift())
map('n', '<C-w>m',     winshift())
map('n', '<C-w><C-x>', winshift('swap'))
map('n', '<C-w>x',     winshift('swap'))
map('n', '<C-w>M',     winshift('swap'))

map('n', '<C-M-H>', winshift('left'))
map('n', '<C-M-J>', winshift('down'))
map('n', '<C-M-K>', winshift('up'))
map('n', '<C-M-L>', winshift('right'))

return { 'sindrets/winshift.nvim',
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
