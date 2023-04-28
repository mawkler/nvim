------------------
-- Git worktree --
------------------

local function switch_worktrees()
  require('telescope').extensions.git_worktree.git_worktrees()
end

local function create_worktrees()
  require('telescope').extensions.git_worktree.create_git_worktree()
end

return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = 'nvim-telescope/telescope.nvim',
  keys = {
    { '<leader>gw', switch_worktrees, 'Switch git worktree' },
    { '<leader>gW', create_worktrees, 'Create git worktree' },
  }
}
