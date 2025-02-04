-----------
-- Yanky --
-----------
return {
  'gbprod/yanky.nvim',
  dependencies = 'rachartier/tiny-glimmer.nvim',
  keys = {
    { 'y',         '<Plug>(YankyYank)',                    mode = {'n', 'x'} },
    { 'p',         '<Plug>(YankyPutAfter)',                mode = {'n', 'x'} },
    { 'P',         '<Plug>(YankyPutBefore)',               mode = {'n', 'x'} },
    { '<M-p>',     '<Plug>(YankyCycleForward)',            mode = 'n' },
    { '<M-P>',     '<Plug>(YankyCycleBackward)',           mode = 'n' },
    { ']p',        '<Plug>(YankyPutIndentAfterLinewise)',  mode = 'n' },
    { '[p',        '<Plug>(YankyPutIndentBeforeLinewise)', mode = 'n' },
    { '=p',        '<Plug>(YankyPutAfterFilter)',          mode = 'n' },
    { '=P',        '<Plug>(YankyPutBeforeFilter)',         mode = 'n' },
    { '<leader>y', '<cmd>YankyRingHistory<CR>',            mode = 'n' },
  },
  cmd = { 'YankyRingHistory', 'YankyClearHistory' },
  init = function()
    local map = require('utils').map
    local remap = { remap = true }

    map('n',        'dp',        'yyp',             remap)
    map('n',        'cy',        '"+y',             remap)
    map('x',        'Y',         '"+y',             remap)
    map('n',        'cY',        '"+y$',            remap)
    map('n',        'cp',        '"+p',             remap)
    map('s',        '<M-S-p>',   '<C-r>+',          remap)
    map('n',        'cP',        '"+P',             remap)
    map('n',        'Y',         'y$',              remap)
    map('!',        '<M-p>',     '<C-r><C-o>"',     remap)
    map('!',        '<M-S-p>',   '<C-r><C-o>+',     remap)
    map('s',        '<M-p>',     '<C-g>pgv<C-g>',   remap)
    map('s',        '<M-S-p>',   '<C-g>"+pgv<C-g>', remap)
  end,
  config = function()
    vim.api.nvim_set_hl(0, 'YankyPut',    { link = 'IncSearch' })
    vim.api.nvim_set_hl(0, 'YankyYanked', { link = 'IncSearch' })

    require('telescope').load_extension('yank_history')

    require('yanky').setup({
      highlight = {
        on_put = false,
        on_yank = false,
      },
      ring = { update_register_on_cycle = true },
    })
  end
}
