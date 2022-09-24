------------------
-- Smart splits --
------------------
return { 'mrjones2014/smart-splits.nvim',
  keys = {
    '<M-S-h>',
    '<M-S-j>',
    '<M-S-k>',
    '<M-S-l>',
    '<Left>',
    '<Down>',
    '<Up>',
    '<Right>',
    '<C-w>z',
  },
  config = function() import('smart-splits', function(smart_splits)
    local map = require('utils').map

    smart_splits.setup({})

    local function resize(direction)
      return function()
        local count = vim.v.count ~= 0 and vim.v.count or 3
        smart_splits['resize_' .. direction](count)
      end
    end

    map('n', '<M-S-h>', resize('left'),                 'Resize left')
    map('n', '<M-S-j>', resize('down'),                 'Resize down')
    map('n', '<M-S-k>', resize('up'),                   'Resize up')
    map('n', '<M-S-l>', resize('right'),                'Resize right')
    map('n', '<Left>',  resize('left'),                 'Resize left')
    map('n', '<Down>',  resize('down'),                 'Resize down')
    map('n', '<Up>',    resize('up'),                   'Resize up')
    map('n', '<Right>', resize('right'),                'Resize right')
    map('n', '<C-w>z',  smart_splits.start_resize_mode, 'Enter resize mode')
  end)
  end,
}
