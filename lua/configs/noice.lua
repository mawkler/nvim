return { 'folke/noice.nvim',
  requires = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  event = 'VimEnter',
  config = function()
    require('noice').setup()
  end
}
