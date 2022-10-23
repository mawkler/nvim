----------------
-- Substitute --
----------------
return {
  'gbprod/substitute.nvim',
  setup = function()
    local map = require('utils').map
    local substitute = require('substitute')
    local exchange = require('substitute.exchange')

    map('n', 'su',  substitute.operator, { desc = 'Substitute operator' })
    map('n', 'suu', substitute.line,     { desc = 'Substitute line' })
    map('n', 'sU',  substitute.eol,      { desc = 'Substitute eol' })
    map('x', 'su',  substitute.visual,   { desc = 'Substitute visual' })

    map("n", "sx",  exchange.operator, { desc = 'Exchange operator' })
    map("n", "sxx", exchange.line,     { desc = 'Exchange line' })
    map("x", "X",   exchange.visual,   { desc = 'Exchange visual' })
    map("n", "sxc", exchange.cancel,   { desc = 'Exchange cancel' })
  end,
  config = function()
    require('substitute').setup()
  end
}
