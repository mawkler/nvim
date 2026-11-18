----------------
-- Diffbandit --
----------------
local next_hunk = ']g'
local prev_hunk = '[g'

return {
  'CoreyKaylor/diffbandit.nvim',
  cmd = {
    'DiffBandit',
    'DiffBanditBuffers',
    'DiffBanditFolderDiff',
    'DiffBanditGit',
    'DiffBanditGitCurrent',
    'DiffBanditCommitPanel',
    'DiffBanditGitMenu',
    'DiffBanditGitLog',
    'DiffBanditGitCommit',
    'DiffBanditGitCompare',
    'DiffBanditGitCheckout',
    'DiffBanditMerge',
  },
  keys = {
    { '<leader>gd',  '<cmd>DiffBanditGit<CR>' },
    { '<leader>gH',  '<cmd>DiffBanditGitLog<CR>' },
    { '<leader>gfH', '<cmd>DiffBanditGitLog %<CR>' },
  },
  opts = {
    navigation = {
      close_key = '<C-c>',
      hunk_keys = {
        next = next_hunk,
        prev = prev_hunk,
      },
      -- Keep `[d`/`]d` for diagnostics
      document_keys = {
        top = false,
        bottom = false,
      },
    },
    actions = {
      keys = {
        toggle_stage = '<leader>ghs',
      },
    },
    git = {
      file_keys = {
        next = '<C-j>',
        prev = '<C-k>',
      },
      panel = {
        keys = {
          close = '<C-c>',
          toggle_panel = '`',
          focus_panel = '~',
        },
      },
    },
    merge = {
      keys = {
        close = '<C-c>',
        toggle_panel = '`',
        focus_panel = '~',
        next_conflict = next_hunk,
        prev_conflict = prev_hunk,
      },
    },
    folder = {
      keys = {
        close = '<C-c>',
      },
    },
    ui = {
      -- Neovide doesn't support Kitty graphics yet
      connector_renderer = vim.fn.exists('g:neovide') == 1 and 'cells' or nil,
      theme = {
        -- Use the colorscheme's diff colors even if they're subtle
        min_background_delta = 0,
      },
    }
  },
}
