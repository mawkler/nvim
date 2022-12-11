-----------
-- Yanky --
-----------
return { 'gbprod/yanky.nvim',
  keys = {
    '<Plug>(YankyYank)',
    '<Plug>(YankyPutAfter)',
    '<Plug>(YankyPutBefore)',
    '<Plug>(YankyCycleForward)',
    '<Plug>(YankyCycleBackward)',
    '<Plug>(YankyPutIndentAfterLinewise)',
    '<Plug>(YankyPutIndentBeforeLinewise)',
    '<Plug>(YankyPutIndentAfterLinewise)',
    '<Plug>(YankyPutIndentBeforeLinewise)',
    '<Plug>(YankyPutAfterFilter)',
    '<Plug>(YankyPutBeforeFilter)',
  },
  cmd = { 'YankyRingHistory', 'YankyClearHistory' },
  setup = function()
    local map = require('utils').map
    local remap = { remap = true }

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

    map({'n', 'x'}, '<leader>y', '<cmd>YankyRingHistory<CR>')

    map('n', 'dp',        'yyp',             remap)
    map('n', 'cy',        '"+y',             remap)
    map('x', 'Y',         '"+y',             remap)
    map('n', 'cY',        '"+y$',            remap)
    map('n', 'cp',        '"+p',             remap)
    map('s', '<leader>p', '<C-r>+',          remap)
    map('n', 'cP',        '"+P',             remap)
    map('n', 'Y',         'y$',              remap)
    map('!', '<M-p>',     '<C-r><C-o>"',     remap)
    map('!', '<M-S-p>',   '<C-r><C-o>+',     remap)
    map('s', '<M-p>',     '<C-g>pgv<C-g>',   remap)
    map('s', '<M-S-p>',   '<C-g>"+pgv<C-g>', remap)
  end,
  config = function()
    vim.api.nvim_set_hl(0, 'YankyPut',    { link = 'IncSearch' })
    vim.api.nvim_set_hl(0, 'YankyYanked', { link = 'IncSearch' })

    require('telescope').load_extension('yank_history')

    require('yanky').setup({
      highlight = { timer = 150 },
    })
  end
}
