----------
-- Leap --
----------

local mode = { 'n', 'x', 'o' }

return {
  'ggandor/leap.nvim',
  dependencies = 'tpope/vim-repeat',
  keys = {
    { 'zj',   '<Plug>(leap-forward)',      mode = mode, desc = 'Leap downwards' },
    { 'zl',   '<Plug>(leap-forward)',      mode = mode, desc = 'Leap downwards' },
    { 'zk',   '<Plug>(leap-backward)',     mode = mode, desc = 'Leap upwards' },
    { 'zh',   '<Plug>(leap-backward)',     mode = mode, desc = 'Leap upwards' },
    { 'zJ',   '<Plug>(leap-forward-x)',    mode = mode, desc = 'Leap downwards (inclusive)' },
    { 'zK',   '<Plug>(leap-backward-x)',   mode = mode, desc = 'Leap upwards (inclusive)' },
    { '<CR>', '<Plug>(leap-cross-window)', mode = mode, desc = 'Leap to any window' },
    {
      'gs',
      function() require('leap.treesitter').select() end,
      mode = { 'x', 'o' },
      desc = 'Leap select treesitter text-object',
    },
    {
      'gS',
      'V<cmd>lua require("leap.treesitter").select()<cr>',
      mode = { 'x', 'o' },
      desc = 'Leap select treesitter text-object (linewise)',
    }
  },
  config = function()
    require('leap').setup({
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
          vim.cmd.fclose({ bang = true })
        end
      end,
      group = 'Leap'
    })
  end
}
