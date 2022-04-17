---------
-- Bqf --
---------
return { 'kevinhwang91/nvim-bqf',
  event = 'FileType qf',
  config = function()
    require('../quickfix') -- Better quickfix
    require('bqf').setup {
      func_map = {
        prevfile  = '<C-k>',
        nextfile  = '<C-j>',
        fzffilter = '<C-p>',
        split     = '<C-s>',
      }
    }
  end
}
