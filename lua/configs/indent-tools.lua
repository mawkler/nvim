------------------
-- Indent Tools --
------------------
return {
  'arsham/indent-tools.nvim',
  requires = 'arsham/arshlib.nvim',
  keys = {{ 'x', 'iI' }, { 'o', 'iI' }},
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
