---------
-- Git --
---------
return { 'TimUntersberger/neogit',
  config = function()
    local map = require('../utils').map
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

    map('n', '<leader>gc', '<cmd>Neogit commit<CR>')
    map('n', '<leader>gp', '<cmd>Neogit pull<CR>')
    map('n', '<leader>gP', '<cmd>Neogit push<CR>')
    map('n', '<leader>gr', '<cmd>Neogit rebase<CR>')
    map('n', '<leader>gl', '<cmd>Neogit log<CR>')
    map('n', '<leader>gB', '<cmd>Git blame<CR>', 'Git blame every line')
    map('n', '<leader>gC', require('telescope.builtin').git_branches, 'Telescope git branch')
    map('n', '<leader>gs', function() return neogit.open({
      cwd = vim.fn.expand('%:p:h'),
      kind = 'vsplit',
    }) end, 'Neogit status')

    -- TODO: replace with Neogit or Diffview diff once feature is available
    map('n', '<leader>gd', function() call('GitDiff') end, 'Git diff current file')
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

    vim.opt.fillchars = { diff = ' ' }
  end
}
