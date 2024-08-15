-------------
-- Trouble --
-------------
return {
  'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  keys = {
    { '<leader>E', '<cmd>Trouble diagnostics focus<CR>', mode = 'n' }
  },
  config = function()
    require('trouble').setup({
      auto_preview = false,
      use_diagnostic_signs = true,
      auto_close = true,
      keys = {
        ['<Esc>']   = 'close',
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
    })
  end
}
