-------------------
-- Visual repeat --
-------------------
return {
  'inkarkat/vim-visualrepeat',
  dependencies = { 'inkarkat/vim-ingo-library', 'tpope/vim-repeat' },
  event = 'ModeChanged *:[vV]',
}
