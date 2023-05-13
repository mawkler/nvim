---------
-- Bqf --
---------
return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = { 'junegunn/fzf', build = vim.fn['fzf#install'] },
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
