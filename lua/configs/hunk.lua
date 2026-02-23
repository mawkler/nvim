----------
-- Hunk --
----------
return {
  'julienvincent/hunk.nvim',
  cmd = 'DiffEditor',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    keys = {
      global = {
        quit = { 'q' },
        accept = { '<S-CR>' },
        focus_tree = { '`' },
      },
      tree = {
        expand_node = { 'l', },
        collapse_node = { 'h', },
        open_file = { 'l' },
        toggle_file = { 'a', '<space>' },
      },
      diff = {
        toggle_hunk = { '<S-space>' },
        -- This is like toggle_line but it will also toggle the line on the other
        -- 'side' of the diff.
        toggle_line_pair = { '<space>' },
        toggle_line = { '<C-space>' },

        prev_hunk = { '[' },
        next_hunk = { ']' },

        -- Jump between the left and right diff view
        toggle_focus = { '<Tab>' },
      },
    },
  }
}
