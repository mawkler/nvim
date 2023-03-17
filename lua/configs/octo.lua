----------
-- Octo --
----------
return {
  'pwntester/octo.nvim',
  event = 'CmdlineEnter',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  config = function ()
    require('octo').setup({
      default_remote = { 'upstream', 'origin', 'fork' }
    })
  end
}
