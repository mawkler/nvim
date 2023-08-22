-----------
-- Blame --
-----------
return {
  'FabijanZulj/blame.nvim',
  cmd = { 'ToggleBlame', 'EnableBlame', 'DisableBlame' },
  keys = {
    { 'gB', '<cmd>ToggleBlame<CR>', desc = 'Git blame file' },
  },
}
