------------------
-- Indent Tools --
------------------
return {
  'arsham/indent-tools.nvim',
  requires = 'arsham/arshlib.nvim',
  keys = { ']i', '[i', { 'x', 'ii' }, { 'o', 'ii' } },
  config = function()
    require('indent-tools').config({})
  end,
}
