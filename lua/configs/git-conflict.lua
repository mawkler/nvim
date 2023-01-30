------------------
-- Git conflict --
------------------
return { 'akinsho/git-conflict.nvim',
  version = '*', -- `main` is unstable
  config = function()
    local map = require('utils').map

    require('git-conflict').setup({
      default_mappings = false,
      disable_diagnostics = true,
    })

    map('n', 'gc<', '<Plug>(git-conflict-ours)', 'Git conflict take ours')
    map('n', 'gc>', '<Plug>(git-conflict-theirs)', 'Git conflict take theirs')
    map('n', 'gcb', '<Plug>(git-conflict-both)', 'Git conflict take both')
    map('n', 'gc0', '<Plug>(git-conflict-none)', 'Git conflict take none')
    map('n', ']x',  '<Plug>(git-conflict-next-conflict)', 'Next conflict')
    map('n', '[x',  '<Plug>(git-conflict-prev-conflict)', 'Previous conflict')
  end
}
