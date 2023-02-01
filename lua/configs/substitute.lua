----------------
-- Substitute --
----------------

local map = require('utils').map
local substitute = require('substitute')
local exchange = require('substitute.exchange')

return { 'gbprod/substitute.nvim',
  keys = {
    { 'su',         mode = { 'n', 'x' } },
    { 'sU',         mode = { 'n', 'x' } },
    { '<leader>su', mode = 'x' },
    { 'X',          mode = 'x' },
    { 'sx' },
  },
  dependencies = 'gbprod/yanky.nvim',
  config = function()
    local function sub_clipboard(action)
      return function()
        substitute[action]({ register = '+' })
      end
    end

    local function sub_clipboard_visual()
      substitute.visual({ register = '+' })
    end

    map('n', 'su',   substitute.operator,       'Substitute operator')
    map('n', 'suu',  substitute.line,           'Substitute line')
    map('n', 'sU',   substitute.eol,            'Substitute eol')
    map('x', 'su',   substitute.visual,         'Substitute visual')
    map('n', 'suc',  sub_clipboard('operator'), 'Substitute (clipboard)')
    map('n', 'succ', sub_clipboard('line'),     'Substitute line (clipboard)')
    map('n', 'suC',  sub_clipboard('eol'),      'Substitute eol (clipboard)')
    map('x', 'sU',   sub_clipboard_visual,      'Substitute (clipboard)')
    map('n', 'sx',   exchange.operator,         'Exchange operator')
    map('n', 'sxx',  exchange.line,             'Exchange line')
    map('x', 'sx',   exchange.visual,           'Exchange visual')
    map('n', 'sxc',  exchange.cancel,           'Exchange cancel')

    substitute.setup({
      on_substitute = require('yanky.integration').substitute(),
    })
  end
}
