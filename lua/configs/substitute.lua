----------------
-- Substitute --
----------------
return { 'gbprod/substitute.nvim',
  setup = function()
    local map = require('utils').map
    local substitute = require('substitute')
    local exchange = require('substitute.exchange')

    local function sub_clipboard_op()
      substitute.operator({ register = '+' })
    end

    local function sub_clipboard_visual()
      substitute.visual({ register = '+' })
    end

    map('n', 'su',         substitute.operator,  'Substitute operator')
    map('n', 'suu',        substitute.line,      'Substitute line')
    map('n', 'sU',         substitute.eol,       'Substitute eol')
    map('x', 'su',         substitute.visual,    'Substitute visual')
    map('n', 'suc',        sub_clipboard_op,     'Substitute (clipboard)')
    map('x', '<leader>su', sub_clipboard_visual, 'Substitute (clipboard)')
    map('n', 'sx',         exchange.operator,    'Exchange operator')
    map('n', 'sxx',        exchange.line,        'Exchange line')
    map('x', 'X',          exchange.visual,      'Exchange visual')
    map('n', 'sxc',        exchange.cancel,      'Exchange cancel')

  end,
  config = function()
    require('substitute').setup({
      on_substitute = function(event)
        require('yanky').init_ring(
          'p',
          event.register,
          event.count,
          event.vmode:match('[vV]')
        )
      end,
    })
  end
}
