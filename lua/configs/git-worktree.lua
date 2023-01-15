return { 'ThePrimeagen/git-worktree.nvim',
  config = function()
    local map = require('utils').map
    local telescope_worktree = require('telescope').extensions.git_worktree

    map('n', '<leader>gw', telescope_worktree.git_worktrees, 'Switch git worktree')
    map('n', '<leader>gW', telescope_worktree.create_git_worktree, 'Create git worktree')
  end
}
