---------
-- Git --
---------
vim.opt.fillchars = { diff = ' ' }

return { 'TimUntersberger/neogit',
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
    { 'gB',         '<cmd>Git blame<CR>',     desc = 'Git blame every line' },
  },
  config = function()
    local map = require('utils').map
    local cmd, call = vim.cmd, vim.call

    local neogit = require('neogit')
    neogit.setup {
      commit_popup = {
        kind = 'vsplit',
      },
      signs = {
        section = { '', '' },
        item = { '', '' },
      },
      integrations = { diffview = true  },
      disable_builtin_notifications = true,
      disable_commit_confirmation = true,
    }

    map('n', '<leader>gC', require('telescope.builtin').git_branches, 'Git checkout')
    map('n', '<leader>gs', function() neogit.open({
      cwd = vim.fn.expand('%:p:h'),
      kind = 'vsplit',
    }) end, 'Neogit status')

    -- TODO: replace with Neogit or Diffview diff once feature is available
    map('n', '<leader>gd', function() vim.fn.GitDiff() end, 'Git diff current file')
    cmd [[
      function! GitDiff() abort
        let tmp = g:bufferline.insert_at_end
        let g:bufferline.insert_at_end = v:false
        tabnew %
        exe 'Gvdiffsplit'
        exe 'BufferMovePrevious'
        windo set wrap
        let g:bufferline.insert_at_end = tmp
      endf
    ]]
  end
}
