--------------
-- Overseer --
--------------
return {
  'stevearc/overseer.nvim',
  config = function()
    local overseer = require('overseer')
    local map = require('utils').map

    overseer.setup(({
      -- Template modules to load
      templates = { 'builtin' },
      task_list = {
        bindings = {
          ['{'] = 'DecreaseWidth',
          ['}'] = 'IncreaseWidth',
          ['['] = 'PrevTask',
          [']'] = 'NextTask',
        },
      },
    }))

    map('n', '<leader>o', overseer.open, 'Overseer')
  end
}
