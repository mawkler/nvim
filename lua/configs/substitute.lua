----------------
-- Substitute --
----------------
return { 'gbprod/substitute.nvim',
  keys = {
    { 'n', 'su' },
    { 'x', 'su' },
    { 'n', 'sU' },
    { 'x', 'sU' },
    { 'x', '<leader>su' },
    { 'n', 'sx' },
    { 'x', 'X' },
  },
  requires = 'gbprod/yanky.nvim',
  after = 'yanky.nvim', -- Doesn't work for some reason
  config = function()
    local map = require('utils').map
    local substitute = require('substitute')
    local exchange = require('substitute.exchange')

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
    map('n', 'succ', sub_clipboard('line'),     'Substitute (clipboard)')
    map('x', 'sU',   sub_clipboard_visual,      'Substitute (clipboard)')
    map('n', 'sx',   exchange.operator,         'Exchange operator')
    map('n', 'sxx',  exchange.line,             'Exchange line')
    map('x', 'sx',   exchange.visual,           'Exchange visual')
    map('n', 'sxc',  exchange.cancel,           'Exchange cancel')

    -- Make sure Yanky is loaded
    if not packer_plugins['yanky.nvim'].loaded then
      vim.cmd 'PackerLoad yanky.nvim'
    end

    substitute.setup({
      on_substitute = require('yanky.integration').substitute(),
    })
  end
}
