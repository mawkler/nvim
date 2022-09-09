----------
-- Leap --
----------
return { 'ggandor/leap.nvim',
  keys = { 'zj', 'zk', '<CR>' },
  config = function()
    local utils = require('utils')
    local map, plugin_setup = utils.map, utils.plugin_setup

    plugin_setup('leap', {
      case_sensitive = false,
      safe_labels = {
        'h', 'j', 'k', 'l', 'f', ';', "'", 'm', 'w', 'e', 'n', 'u', '/', ',',
        'b', 't', '[', ']', 'H', 'L', 'F', ':', '"',
      },
    })

    map({'n', 'x', 'o'}, 'zj',   '<Plug>(leap-forward)',      'Leap downwards')
    map({'n', 'x', 'o'}, 'zk',   '<Plug>(leap-backward)',     'Leap upwards')
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
