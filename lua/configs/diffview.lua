--------------
-- Diffview --
--------------

-- Opens diff view with the file tree closed
local function diff_file()
  vim.cmd.DiffviewOpen()
  vim.cmd.DiffviewToggleFiles()
end

return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewFocusFiles',
    'DiffviewToggleFiles',
    'DiffviewFileHistory',
    'DiffviewRefresh',
    'DiffviewLog',
  },
  init = function()
    local map = require('utils').map
    map('n', '<leader>gD', '<cmd>DiffviewOpen --untracked-files=no<CR>')
    map('n', '<leader>gd', diff_file)
    map('n', '<leader>gH', '<cmd>DiffviewFileHistory %<CR>')
  end,
  config = function()
    local actions = require('diffview.config').actions

    require('diffview').setup({
      enhanced_diff_hl = true,
      file_panel = {
        win_config = { width = 40 }
      },
      file_history_panel = {
        ['<C-c>'] = actions.close,
        win_config = { height = 15 },
      },
      key_bindings = {
        view = {
          ['<C-j>'] = actions.select_next_entry,
          ['<C-k>'] = actions.select_prev_entry,
          ['<C-t>'] = actions.goto_file_tab,
          ['~']     = actions.focus_files,
          ['`']     = actions.toggle_files,
          ['gb']    = actions.open_commit_log,
          ['<C-c>'] = vim.cmd.DiffviewClose,
        },
        file_panel = {
          ['<Space>']  = actions.select_entry,
          ['<CR>']     = actions.focus_entry,
          ['gf']       = actions.goto_file_edit,
          ['<C-j>']    = actions.select_next_entry,
          ['<C-k>']    = actions.select_prev_entry,
          ['<C-t>']    = actions.goto_file_tab,
          ['<C-c>']    = vim.cmd.DiffviewClose,
          ['<space>e'] = false,
          ['<space>b'] = false,
        },
        file_history_panel = {
          ['!']        = actions.options,
          ['<CR>']     = actions.open_in_diffview,
          ['<Space>']  = actions.select_entry,
          ['<C-j>']    = actions.select_next_entry,
          ['<C-k>']    = actions.select_prev_entry,
          ['gf']       = actions.goto_file,
          ['<C-t>']    = actions.goto_file_tab,
          ['~']        = actions.focus_files,
          ['`']        = actions.toggle_files,
          ['<C-c>']    = vim.cmd.DiffviewClose,
          ['<space>e'] = false,
          ['<space>b'] = false,
        },
        option_panel = {
          ['<CR>']  = actions.select_entry,
          ['<C-c>'] = vim.cmd.DiffviewClose,
        },
      }
    })
  end
}
