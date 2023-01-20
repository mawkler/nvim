--------------
-- Barbecue --
--------------
return { 'utilyre/barbecue.nvim',
  requires = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },
  after = 'nvim-web-devicons',
  config = function()
    require('barbecue').setup({
      kinds = require('utils.icons').icons
    })
  end
}
