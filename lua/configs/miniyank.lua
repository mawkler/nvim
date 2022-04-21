--------------
-- Miniyank --
--------------
return { 'bfredl/nvim-miniyank',
  keys = {
    {'n', 'y'},
    {'n', 'p'},
    {'n', '<M-p>'},
  },
  config = function()
    local map = require('../utils').map

    map('n',        'p',     '<Plug>(miniyank-autoput)')
    map('n',        'P',     '<Plug>(miniyank-autoPut)')
    map({'n', 'x'}, '<M-p>', '<Plug>(miniyank-cycle)')
    map({'n', 'x'}, '<M-P>', '<Plug>(miniyank-cycleback)')
    map('x',        'p',     '"_dPP', { remap = true })
  end,
}
