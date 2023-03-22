---------------
-- Autopairs --
---------------
return {
  'windwp/nvim-autopairs',
  dependencies = 'hrsh7th/nvim-cmp',
  event = { 'InsertEnter' },
  config = function()
    local rule = require('nvim-autopairs.rule')
    local autopairs = require('nvim-autopairs')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    -- Auto insert `()` after completing a function or method
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done {
      map_char = { tex = '' },
    })

    autopairs.setup({
      map_c_h = true,
      disable_filetype = { 'TelescopePrompt', 'DressingInput' },
    })

    autopairs.add_rules {
      rule('$', '$', 'tex'),
      rule('*', '*', 'markdown'),
    }
  end
}
