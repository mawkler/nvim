----------------
-- Possession --
----------------
return { 'jedrzejboczar/possession.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  module_pattern = 'possession',
  config = function()
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('possession', {
      silent = true,
      autosave = {
        current = true,
        tmp = true,
        tmp_name = 'default',
      },
    })
  end
}
