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
        quit = { 'q', '<C-c>' },
        accept = { '<C-s>' },
        focus_tree = { '`' },
      },
      tree = {
        expand_node = { 'l', },
        collapse_node = { 'h', },
        open_file = { '<CR>' },
        toggle_file = { 'a', '<space>' },
      },
      diff = {
        toggle_hunk = { 'A', '<S-space>' },
        toggle_line_pair = { 'a', '<space>' },
        toggle_line = { '<C-space>' },

        prev_hunk = { '[' },
        next_hunk = { ']' },

        -- Jump between the left and right diff view
        toggle_focus = { '<Tab>' },
      },
    },
    hooks = {
      on_diff_mount = function()
        vim.keymap.set('n', '<Esc>', '', { buffer = true })
        pcall(vim.cmd.WindowsDisableAutowidth)
      end,
      on_tree_mount = function()
        vim.keymap.set('n', '<Esc>', '', { buffer = true })
        pcall(vim.cmd.WindowsDisableAutowidth)
      end,
    }
  }
}
