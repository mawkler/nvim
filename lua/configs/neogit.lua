---------
-- Git --
---------
return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  keys = {
    '<leader>gC',
    '<leader>gs',
    '<leader>gd',
    { '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Git commit' },
    { '<leader>gp', '<cmd>Neogit pull<CR>',   desc = 'Git pull' },
    { '<leader>gP', '<cmd>Neogit push<CR>',   desc = 'Git push' },
    { '<leader>gr', '<cmd>Neogit rebase<CR>', desc = 'Git rebase' },
    { '<leader>gl', '<cmd>Neogit log<CR>',    desc = 'Git log' },
  },
  config = function()
    local map = require('utils').map
    local neogit = require('neogit')

    neogit.setup({
      popup = {
        kind = 'vsplit',
      },
      ---@diagnostic disable-next-line: missing-fields
      commit_editor = {
        staged_diff_split_kind = 'vsplit',
      },
      ---@diagnostic disable-next-line: missing-fields
      signs = {
        section = { '', '' },
        item = { '', '' },
      },
      ignored_settings = { 'NeogitCommitPopup--all' },
      integrations = {
        telescope = true,
        diffview = true,
        fzf_lua = true,
      },
      disable_builtin_notifications = true,
      disable_commit_confirmation = true,
    })

    map('n', '<leader>gC', require('telescope.builtin').git_branches, 'Git checkout')
    map('n', '<leader>gs', function() neogit.open({
      cwd = vim.fn.expand('%:p:h'),
      kind = 'vsplit',
    }) end, 'Neogit status')
  end
}
