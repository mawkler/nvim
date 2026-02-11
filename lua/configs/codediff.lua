--------------
-- Codediff --
--------------
return {
  'esmuellert/codediff.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  cmd = 'CodeDiff',
  keys = {
    'gc<',
    'gc>',
    'gcb',
    'gcx',
    ']x',
    '[x',
    '2do',
    '3do',
    { '<leader>gd',  '<cmd>CodeDiff<CR>' },
    { '<leader>gH',  '<cmd>CodeDiff history<CR>' },
    { '<leader>gfH', '<cmd>CodeDiff history %<CR>' },
  },
  opts = {
    explorer = {
      initial_focus = 'modified',
      icons = {
        folder_closed = '',
        folder_open = '',
      },
      view_mode = 'tree',
    },
    keymaps = {
      view = {
        quit = '<C-c>',
        toggle_explorer = '`',
        next_hunk = ']g',
        prev_hunk = '[g',
        next_file = '<c-j>',
        prev_file = '<c-k>',
      },
      explorer = {
        select = '<space>',
        toggle_view_mode = 'i',
      },
      history = {
        select = '<space>',
      },
      conflict = {
        accept_incoming = 'gc<', -- Accept incoming (theirs/left) change
        accept_current = 'gc>',  -- Accept current (ours/right) change
        accept_both = 'gcb',
        discard = 'gcx',
        next_conflict = ']x',
        prev_conflict = '[x',
        diffget_incoming = '2do',
        diffget_current = '3do',
      },
    },
  }
}
