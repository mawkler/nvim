---------------
-- Autopairs --
---------------
return { 'windwp/nvim-autopairs',                -- Auto-close brackets, etc.
  event = 'InsertEnter' ,
  config = function()

    -- Auto insert `()` after completing a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done {
      map_char = { tex = '' },
    })

    local rule = require('nvim-autopairs.rule')
    local autopairs = require('nvim-autopairs')

    autopairs.setup { map_c_h = true }
    autopairs.add_rules {
      rule('$', '$', 'tex'),
      rule('*', '*', 'markdown'),
    }
  end
}
