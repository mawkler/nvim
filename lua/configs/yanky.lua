-----------
-- Yanky --
-----------
return { 'gbprod/yanky.nvim',
  keys = {
    { 'n', 'y' },
    { 'x', 'y' },
    { 'n', 'Y' },
    { 'x', 'Y' },
    { 'n', 'p' },
    { 'x', 'p' },
    { 'n', 'P' },
    { 'x', 'P' },
    { 'n', '<M-p>' },
    { 'n', '<M-P>' },
    { 'n', ']p' },
    { 'n', '[p' },
    { 'n', ']P' },
    { 'n', '[P' },
    { 'n', '=p' },
    { 'n', '=P' },
  },
  cmd = { 'YankyRingHistory', 'YankyClearHistory' },
  setup = function()
    local map = require('utils').map
    map('n', 'dp',        'yyp')
    map('n', 'cy',        '"+y')
    map('x', 'Y',         '"+y')
    map('n', 'cY',        '"+y$')
    map('n', 'cp',        '"+p',    { remap = true })
    map('s', '<leader>p', '<C-r>+', { remap = true })
    map('n', 'cP',        '"+P',    { remap = true })
    map('n', 'Y',         'y$',     { remap = true })
    map('!', '<M-v>',     '<C-r>+')
  end,
  config = function()
    local plugin_setup = require('utils').plugin_setup
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

    vim.api.nvim_set_hl(0, 'YankyPut',    { link = 'IncSearch' })
    vim.api.nvim_set_hl(0, 'YankyYanked', { link = 'IncSearch' })

    require('telescope').load_extension('yank_history')

    plugin_setup('yanky', {
      highlight = { timer = 150 },
    })
  end
}
