------------
-- Brygga --
------------
return {
  'ThorstenRhau/brygga.nvim',
  version = '*',
  event = 'VeryLazy',
  keys = {
    { '<leader>C', ':Brygga send<CR>', mode = { 'n', 'x' }, { desc = 'Send selection to Claude' } },
  },
  opts = {},
}
