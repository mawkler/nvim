----------------
-- FastAction --
----------------
return {
  'Chaitanyabsprip/fastaction.nvim',
  keys = {
    { '<leader>a', function() require('fastaction').code_action() end,       mode = 'n', desc = 'LSP code action' },
    { '<leader>a', function() require('fastaction').range_code_action() end, mode = 'x', desc = 'LSP code action' },
  },
  opts = {
    dismiss_keys = { '<C-c>', '<Esc>' },
    keys = 'qwertyuiopasdfghjklzxcvbnm',
  }
}
