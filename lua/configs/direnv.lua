------------
-- Direnv --
------------
return {
  'NotAShelf/direnv.nvim',
  config = function()
    require('direnv').setup {
      autoload_direnv = true,
      statusline = {
        enabled = true,
        icon = '',
      },
    }
  end,
}
