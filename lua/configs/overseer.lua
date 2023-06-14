--------------
-- Overseer --
--------------
return {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>o', '<cmd>OverseerOpen<CR>', desc = 'Overseer' },
  },
  cmd = {
    'OverseerOpen',
    'OverseerClose',
    'OverseerToggle',
    'OverseerSaveBundle',
    'OverseerLoadBundle',
    'OverseerDeleteBundle',
    'OverseerRunCmd',
    'OverseerRun',
    'OverseerInfo',
    'OverseerBuild',
    'OverseerQuickAction',
    'OverseerClearCache',
  },
  opts = {
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
  }
}
