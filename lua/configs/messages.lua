--------------
-- Messages --
--------------
return {
  'AckslD/messages.nvim',
  cmd = 'Messages',
  init = function()
    -- noice.nvim has this functionality built-in
    if not require('utils').noice_is_loaded() then
      local map = require('utils').map
      map('n', 'gm', '<cmd>Messages<CR>', 'Show messages in a floating window')
    end
  end,
  config = function()
    local map = require('utils').map

    require('messages').setup({
      post_open_float = function(winnr)
        map('n', '<Esc>', function()
          vim.api.nvim_win_close(winnr, false)
        end, { buffer = true, desc = 'Close :Messages window' })
      end
    })
  end
}
