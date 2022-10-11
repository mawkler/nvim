------------------
-- Guess indent --
------------------
return { 'NMAC427/guess-indent.nvim',
  config = function()
    local plugin_setup = require('utils').plugin_setup
    plugin_setup('guess-indent')
  end,
}
