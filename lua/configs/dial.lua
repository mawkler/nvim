---------------
-- Dial.nvim --
---------------
return {
  'monaqa/dial.nvim',
  keys = {
    { '<C-a>',  '<Plug>(dial-increment)',  mode = { 'n', 'v' }, remap = true },
    { '<C-x>',  '<Plug>(dial-decrement)',  mode = { 'n', 'v' }, remap = true },
    { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true },
    { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true },
  },
  config = function()
    local augend = require('dial.augend')

    local function add_constant(elements)
      return augend.constant.new {
        elements = elements,
        cyclic = true,
        word = true
      }
    end

    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias['%Y/%m/%d'],
        augend.date.alias['%H:%M'],
        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.misc.alias.markdown_header,
        add_constant({'and', 'or'}),
        add_constant({'enable', 'disable'}),
        add_constant({'&&', '||'}),
        add_constant({'TRUE', 'FALSE'}),
        add_constant({'private', 'public'}),
        add_constant({'left', 'right'}),
        add_constant({
          'zero',  'one',   'two',  'three', 'four',   'five', 'six',
          'seven', 'eight', 'nine', 'ten',   'eleven', 'twelve'
        }),
        add_constant({
          'Zero',  'One',   'Two',  'Three', 'Four',   'Five', 'Six',
          'seven', 'Eight', 'Nine', 'Ten',   'Eleven', 'Twelve'
        }),
        add_constant({
          'noll', 'en',  'ett',  'två', 'tre', 'fyra', 'fem',
          'sex',  'sju', 'åtta', 'nio', 'tio', 'elva', 'tolv'
        }),
        add_constant({
          'noll', 'En',  'Ett',  'Två', 'Tre', 'Fyra', 'Fem',
          'sex',  'Sju', 'Åtta', 'Nio', 'Tio', 'Elva', 'Tolv'
        }),
      }
    }
  end
}
