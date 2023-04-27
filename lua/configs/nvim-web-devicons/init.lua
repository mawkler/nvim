-----------------------
-- Nvim web devicons --
-----------------------
return {
  'kyazdani42/nvim-web-devicons',
  priority = 998,
  config = function()
    require('nvim-web-devicons').setup({
      override = require('configs.nvim-web-devicons.icons'),
    })
  end
}
