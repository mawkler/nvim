----------
-- Leap --
----------

local mode = {'n', 'x', 'o'}

return { 'ggandor/leap.nvim',
  dependencies = 'tpope/vim-repeat',
  keys = {
    { 'zj',   '<Plug>(leap-forward)',      mode = mode, desc = 'Leap downwards' },
    { 'zl',   '<Plug>(leap-forward)',      mode = mode, desc = 'Leap downwards' },
    { 'zk',   '<Plug>(leap-backward)',     mode = mode, desc = 'Leap upwards' },
    { 'zh',   '<Plug>(leap-backward)',     mode = mode, desc = 'Leap upwards' },
    { 'zJ',   '<Plug>(leap-forward-x)',    mode = mode, desc = 'Leap downwards (inclusive)' },
    { 'zK',   '<Plug>(leap-backward-x)',   mode = mode, desc = 'Leap upwards (inclusive)' },
    { '<CR>', '<Plug>(leap-cross-window)', mode = mode, desc = 'Leap to any window' },
  },
  init = function()
    local map = require('utils').map
    -- Move default zj/zk bindings to ]z/[z
    map('n', ']z', 'zj', 'Jump to next fold')
    map('n', '[z', 'zk', 'Jump to previous fold')
  end,
  config = function()
    local utils = require('utils')
    require('leap').setup({
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
