-------------
-- Trouble --
-------------
return { 'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  keys = '<leader>E',
  config = function()
    local map = require('utils').map

    require('trouble').setup({
      auto_preview = false,
      use_diagnostic_signs = true,
      auto_close = true,
      action_keys = {
        close = {'<Esc>', '<C-q>', '<C-c>'},
        refresh = 'R',
        jump = {'<Space>'},
        open_split = {'<c-s>'},
        open_vsplit = {'<c-v>'},
        open_tab = {'<c-t>'},
        jump_close = {'<CR>'},
        toggle_mode = 'm',
        toggle_preview = 'P',
        hover = {'gh'},
        preview = 'p',
        close_folds = {'h', 'zM', 'zm'},
        open_folds = {'l', 'zR', 'zr'},
        toggle_fold = {'zA', 'za'},
        previous = 'k',
        next = 'j',
        cancel = nil,
      },
    })
    map('n', '<leader>E', '<cmd>TroubleToggle<CR>')
  end
}
