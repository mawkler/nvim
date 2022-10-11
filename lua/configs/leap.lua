----------
-- Leap --
----------
return { 'ggandor/leap.nvim',
  keys = { 'zj', 'zk', '<CR>' },
  setup = function()
    local map = require('utils').map
    -- Move default zj/zk bindings to ]z/[z
    map('n', ']z', 'zj', 'Jump to next fold')
    map('n', '[z', 'zk', 'Jump to previous fold')
  end,
  config = function()
    local utils = require('utils')
    local map, plugin_setup = utils.map, utils.plugin_setup

    plugin_setup('leap', {
      case_sensitive = false,
      substitute_chars = {
        ['\r'] = '¬', -- This one doesn't seem to work
        [' '] = '·',
      },
      safe_labels = {
        'h', 'j', 'k', 'l', 'f', "'", 'm', 'w', 'e', 'n', 'u', '/', 'b', 't',
        '[', ']', 'H', 'L', 'F', ':', '"',
      },
    })

    map({'n', 'x', 'o'}, 'zj',   '<Plug>(leap-forward)',      'Leap downwards')
    map({'n', 'x', 'o'}, 'zk',   '<Plug>(leap-backward)',     'Leap upwards')
    map({'n', 'x', 'o'}, 'zJ',   '<Plug>(leap-forward-x)',    'Leap downwards (inclusive)')
    map({'n', 'x', 'o'}, 'zK',   '<Plug>(leap-backward-x)',   'Leap upwards (inclusive)')
    map({'n', 'x'},      '<CR>', '<Plug>(leap-cross-window)', 'Leap to any window')

    vim.api.nvim_create_augroup('Leap', {})
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LeapEnter',
      callback = function()
        -- Close any floating windows if current window isn't floating
        if vim.api.nvim_win_get_config(0).relative == '' then
          utils.close_floating_windows()
        end
      end,
      group = 'Leap'
    })
  end
}
