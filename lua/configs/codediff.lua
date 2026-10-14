--------------
-- Codediff --
--------------
return {
  'esmuellert/codediff.nvim',
  cmd = 'CodeDiff',
  keys = {
    { '<leader>gd',  '<cmd>CodeDiff<CR>' },
    { '<leader>gH',  '<cmd>CodeDiff history<CR>' },
    { '<leader>gfH', '<cmd>CodeDiff history %<CR>' },
  },
  opts = {
    diff = {
      disable_inlay_hints = false,
      hide_merge_artifacts = false,
      jump_to_first_change = false,
      compact = true,
    },
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
        focus_explorer = '~',
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
        accept_incoming = '<', -- Accept incoming (theirs/left) change
        accept_current = '>',  -- Accept current (ours/right) change
        diffget_incoming = '<',
        diffget_current = '>',
        accept_both = 'b',
        discard = 'x',
        next_conflict = ']',
        prev_conflict = '[',
      },
    },
  },
}
