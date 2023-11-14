-----------------
-- Icon Picker --
-----------------
return {
  'ziontee113/icon-picker.nvim',
  cmd = { 'IconPickerNormal', 'IconPickerYank', 'IconPickerInsert' },
  keys = {
    { '<leader>ii', '<cmd>IconPickerNormal<cr>', mode = 'n', desc = 'Icon picker' },
    { '<leader>iy', '<cmd>IconPickerYank<cr>',   mode = 'n', desc = 'Icon picker (to clipboard)' },
    { '<M-i>',      '<cmd>IconPickerInsert<cr>', mode = 'i', desc = 'Icon picker' },
  },
  opts = { disable_legacy_commands = true }
}
