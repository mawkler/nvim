------------
-- Direnv --
------------
return {
  'NotAShelf/direnv.nvim',
  config = function()
    require('direnv').setup {
      autoload_direnv = true,
    }
  end,
}
