-------------
-- Trouble --
-------------
return {
  'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  keys = {
    { '<leader>E', '<cmd>Trouble diagnostics toggle<CR>', mode = 'n' }
  },
  config = function()
    require('trouble').setup({
      auto_preview = false,
      auto_close = true,
      warn_no_results = false,
      focus = true,
      keys = {
        ['<esc>']   = 'close',
        ['<C-q>']   = 'close',
        ['<C-c>']   = 'close',
        ['R']       = 'refresh',
        ['<space>'] = 'preview',
        ['<cr>']    = 'jump_close',
        ['l']       = 'fold_open',
        ['h']       = 'fold_close',
        [']']       = 'next',
        ['[']       = 'prev',
        ['[[']      = false,
        [']]']      = false,
      },
      icons = {
        kinds = require('utils.icons').icons,
      },
    })
  end
}
