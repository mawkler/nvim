--------------
-- Eyeliner --
--------------
local mode = { 'n', 'x', 'o' }

return {
  'jinh0/eyeliner.nvim',
  keys = {
    { 't', mode = mode },
    { 'T', mode = mode },
    { 'f', mode = mode },
    { 'F', mode = mode },
  },
  opts = {
    highlight_on_key = true,
  }
}
