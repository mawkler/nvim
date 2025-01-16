--------------
-- Fugitive --
--------------
return {
  'tpope/vim-fugitive',                                
  dependencies = 'tpope/vim-dispatch', -- Asynchronous `:Gpush`, etc.
  cmd = { 'G', 'Git', 'Gvdiffsplit' },
}
