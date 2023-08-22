--------------
-- hlsearch --
--------------
return {
  'nvimdev/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
  end
}
