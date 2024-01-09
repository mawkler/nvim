----------------
-- Easy-align --
----------------
return {
  'junegunn/vim-easy-align',
  dependencies = 'tpope/vim-repeat',
  keys = {
    { 'ga',  '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = 'Align' },
    { 'gaa', 'gaiL',              remap = true,        desc = 'Align line' },
  }
}
