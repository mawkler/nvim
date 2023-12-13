-----------
-- Image --
-----------
return {
  'samodostal/image.nvim',
  event = 'BufReadPre *.JPG,*.jpg,*.png',
  dependencies = { 'nvim-lua/plenary.nvim', 'm00qek/baleia.nvim', },
  opts = {
    render = {
      foreground_color = true,
      background_color = true,
    },
  }
}
