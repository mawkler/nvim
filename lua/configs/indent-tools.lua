------------------
-- Indent Tools --
------------------
return {
  'arsham/indent-tools.nvim',
  dependencies = 'arsham/arshlib.nvim',
  keys = {
    { 'iI', mode = { 'x', 'o' } },
    { 'aI', mode = { 'x', 'o' } },
  },
  config = function()
    require('indent-tools').config({
      textobj = {
        ii = 'iI',
        ai = 'aI',
      },
      normal = {
        up = false,
        down = false,
      },
    })
  end,
}
