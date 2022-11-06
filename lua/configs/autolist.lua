--------------
-- Autolist --
--------------
return { 'gaoDean/autolist.nvim',
  ft = { 'markdown', 'text', 'latex' },
  config = function()
    local map = require('utils').map
    local autolist = require('autolist')

    autolist.setup({
      colon = { indent_raw = false },
    })

    map('n', '<leader>x', autolist.invert)
  end
}
