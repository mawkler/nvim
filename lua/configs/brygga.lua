------------
-- Brygga --
------------
return {
  'ThorstenRhau/brygga.nvim',
  version = '*',
  event = 'VeryLazy',
  keys = {
    { '<leader>C', '<cmd>Brygga send<CR>', mode = 'x', { desc = 'Send selection to Claude' } },
  },
  opts = {},
}
