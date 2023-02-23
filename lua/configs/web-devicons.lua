-----------------------
-- Nvim web devicons --
-----------------------
return { 'kyazdani42/nvim-web-devicons',
  priority = 998,
  config = function()
    require('nvim-web-devicons').set_icon {
      md = {
        icon = '',
        color = '#519aba',
        name = 'Markdown'
      },
      tex = {
        icon = '',
        color = '#3D6117',
        name = 'Tex'
      }
    }
  end
}
