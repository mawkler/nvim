----------
-- Octo --
----------
return {
  'pwntester/octo.nvim',
  event = 'CmdlineEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require('octo').setup({
      default_remote = { 'upstream', 'origin', 'fork' }
    })
  end
}
