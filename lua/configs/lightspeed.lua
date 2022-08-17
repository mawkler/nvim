----------------
-- Lightspeed --
----------------
return { 'ggandor/lightspeed.nvim',
  keys = {'zj', 'zk', '<CR>', '<S-CR>'},
  config = function()
    local utils = require('utils')
    local map = utils.map

    vim.g.lightspeed_no_default_keymaps = true
    require('lightspeed').setup {
      exit_after_idle_msecs = { labeled = 1500 },
      ignore_case = true,
      labels = {},
      safe_labels = {
        'h', 'j', 'k', 'l', 'f', ';', "'", 'm', 'w', 'e', 'n', 'u', '/', ',',
        'b', 't', '[', ']', 'H', 'L', 'F', ':', '"',
      },
    }

    map({'n', 'x', 'o'}, 'zj',     '<Plug>Lightspeed_s',       'Lightspeed jump downwards')
    map({'n', 'x', 'o'}, 'zk',     '<Plug>Lightspeed_S',       'Lightspeed jump upwards')
    map({'n', 'x', 'o'}, '<CR>',   '<Plug>Lightspeed_omni_s',  'Lightspeed jump bidirectionally')
    map({'n', 'x', 'o'}, '<S-CR>', '<Plug>Lightspeed_omni_gs', 'Lightspeed jump to window bidirectionally')

    map('o', 'zJ', '<Plug>Lightspeed_x',  'Lightspeed jump downwards (inclusive op)')
    map('o', 'zK', '<Plug>Lightspeed_X',  'Lightspeed jump upwards (inclusive op)')

    -- Move default zj/zk bindings to ]z/[z
    map('n', ']z', 'zj', 'Jump to next fold using ]z instead of zj')
    map('n', '[z', 'zk', 'Jump to previous fold using [z instead of zk')

    vim.api.nvim_create_augroup('Lightspeed', {})
    vim.api.nvim_create_autocmd('User', {
      pattern  = 'LightspeedEnter',
      callback = utils.close_floating_windows,
      group    = 'Lightspeed'
    })
  end
}
