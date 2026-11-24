--------------
-- Codediff --
--------------
return {
  'esmuellert/codediff.nvim',
  cmd = 'CodeDiff',
  -- keys = {
  --   { '<leader>gd',  '<cmd>CodeDiff<CR>' },
  --   { '<leader>gH',  '<cmd>CodeDiff history<CR>' },
  --   { '<leader>gfH', '<cmd>CodeDiff history %<CR>' },
  -- },
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
        next_file = ']f',
        prev_file = '[f',
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
        next_conflict = ']x',
        prev_conflict = '[x',
      },
    },
  },
  config = function(_, opts)
    require('codediff').setup(opts)

    -- Hide virtual codediff:// buffers from the buffer list (and thus barbar)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = 'codediff://*',
      callback = function(args) vim.bo[args.buf].buflisted = false end,
    })

    -- Write all buffers with <C-s> while resolving conflicts
    local conflict = require('codediff.ui.conflict')
    local lifecycle = require('codediff.ui.lifecycle')
    local setup_keymaps = conflict.setup_keymaps
    conflict.setup_keymaps = function(tabpage)
      setup_keymaps(tabpage)
      local session = lifecycle.get_session(tabpage)
      if not session then return end
      lifecycle.begin_keymap_scope(tabpage, 'wall')
      for _, bufnr in ipairs { session.original_bufnr, session.modified_bufnr, session.result_bufnr } do
        lifecycle.set_buf_keymap(tabpage, bufnr, 'n', '<C-s>', '<Cmd>silent wall<CR>', { desc = 'Write all buffers' })
      end
      lifecycle.end_keymap_scope(tabpage, 'wall')
    end
  end,
}
