-----------------------
-- Nvim web devicons --
-----------------------
return {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  priority = 998,
  config = function()
    require('nvim-web-devicons').setup({
      override = require('configs.nvim-web-devicons.icons'),
    })
  end
}
