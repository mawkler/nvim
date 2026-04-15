------------------
-- Tiny Cmdline --
------------------

-- Assumes that ui2 has been enabled
return {
  'rachartier/tiny-cmdline.nvim',
  init = function()
    vim.o.cmdheight = 0

    vim.g.tiny_cmdline = {
      on_reposition = require('tiny-cmdline').adapters.blink,
      native_types = {}, -- Also use this plugin when searching
    }
  end,
}
