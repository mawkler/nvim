------------------
-- Indent Tools --
------------------
local mode = { 'n', 'x' }
return {
  'arsham/indent-tools.nvim',
  dependencies = 'arsham/arshlib.nvim',
  keys = {
    { '[I', mode = mode },
    { ']I', mode = mode },
  },
  config = function()
    require('indent-tools').config({
      textobj = false, -- Handled by various-textobjs
      normal = {
        up   = '[I',
        down = ']I',
      },
    })
  end,
}
