--------------
-- Overseer --
--------------
return { 'stevearc/overseer.nvim',
  config = function()
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('overseer', ({
      -- Template modules to load
      templates = { 'builtin' },
    }))
  end
}
