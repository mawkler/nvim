---------------
-- Modicator --
---------------
return {
  'mawkler/modicator.nvim',
  event = 'ModeChanged',
  config = function()
    vim.o.termguicolors = true
    vim.o.cursorline = true
    vim.o.number = true

    require('modicator').setup({
      highlights = {
        defaults = { bold = true },
      },
    })
  end
}
