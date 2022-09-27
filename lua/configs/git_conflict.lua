------------------
-- Git conflict --
------------------
return { 'akinsho/git-conflict.nvim',
  tag = '*',
  config = function()
    local map, plugin_setup = require('utils').map, require('utils').plugin_setup

    plugin_setup('git-conflict', {
      default_mappings = false,
      disable_diagnostics = true,
    })

    map('n', 'gc>', '<Plug>(git-conflict-ours)', 'Git conflict take ours')
    map('n', 'gc<', '<Plug>(git-conflict-theirs)', 'Git conflict take theirs')
    map('n', 'gcb', '<Plug>(git-conflict-both)', 'Git conflict take both')
    map('n', 'gc0', '<Plug>(git-conflict-none)', 'Git conflict take none')
    map('n', ']x',  '<Plug>(git-conflict-next-conflict)', 'Next conflict')
    map('n', '[x',  '<Plug>(git-conflict-prev-conflict)', 'Previous conflict')
  end
}
