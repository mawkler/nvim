---------
-- Bqf --
---------
return { 'kevinhwang91/nvim-bqf',
  event = 'FileType qf',
  config = function()
    require('../quickfix') -- Better quickfix
    require('bqf').setup {
      preview = {
        auto_preview = false,
      },
      func_map = {
        fzffilter = '/',
        split     = '<C-s>',
      },
      filter = { -- Adapt fzf's delimiter in nvim-bqf
        fzf = {
          extra_opts = {'--bind', 'alt-a:toggle-all', '--delimiter', '│'}
        }
      },
    }
  end
}
