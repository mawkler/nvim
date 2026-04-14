------------------
-- Tiny Cmdline --
------------------
return {
  'rachartier/tiny-cmdline.nvim',
  init = function()
    require('vim._core.ui2').enable({})

    vim.o.cmdheight = 0

    vim.g.tiny_cmdline = {
      on_reposition = require('tiny-cmdline').adapters.blink,
    }
  end,
}
