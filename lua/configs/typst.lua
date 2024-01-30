-----------
-- Typst --
-----------
return {
  'kaarmu/typst.vim',
  ft = 'typst',
  config = function()
    vim.g.typst_auto_open_quickfix = 0
  end
}
