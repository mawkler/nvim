--------------
-- Overseer --
--------------
return { 'stevearc/overseer.nvim',
  config = function()
    require('overseer').setup(({
      -- Template modules to load
      templates = { 'builtin' },
    }))
  end
}
