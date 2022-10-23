-----------
-- Yanky --
-----------
return { 'gbprod/yanky.nvim',
  setup = function()
    local map = require('utils').map

    map({'n', 'x'}, 'y', '<Plug>(YankyYank)')
    map({'n', 'x'}, 'p', '<Plug>(YankyPutAfter)')
    map({'n', 'x'}, 'P', '<Plug>(YankyPutBefore)')

    map('n', '<M-p>', '<Plug>(YankyCycleForward)')
    map('n', '<M-P>', '<Plug>(YankyCycleBackward)')

    map('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
    map('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
    map('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
    map('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')

    map('n', '=p', '<Plug>(YankyPutAfterFilter)')
    map('n', '=P', '<Plug>(YankyPutBeforeFilter)')
  end,
  config = function()
    vim.api.nvim_set_hl(0, 'YankyPut',    { link = 'IncSearch' })
    vim.api.nvim_set_hl(0, 'YankyYanked', { link = 'IncSearch' })

    require('yanky').setup({
      highlight = {
        timer = 150,
      },
    })
  end
}
