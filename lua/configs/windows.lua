-------------
-- Windows --
-------------
return { 'anuvyklack/windows.nvim',
  event = 'WinEnter',
  dependencies = 'anuvyklack/middleclass',
  config = function()
    require('windows').setup({
      animation = { enable = false },
      ignore = {
        buftype = { 'quickfix', 'help' },
      }
    })

    local map = require('utils').map
    local commands = require('windows.commands')

    map('n', '<C-w><C-f>', commands.maximize, 'Toggle maximized window')
  end
}
