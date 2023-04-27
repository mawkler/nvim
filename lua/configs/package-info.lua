------------------
-- Package Info --
------------------
return {
  'vuki656/package-info.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  priority = 1000,
  config = function()
    require('package-info').setup({
      icons = {
        style = {
          up_to_date = '|  ',
          outdated = '|  ',
        },
      },
      hide_up_to_date = true,
      package_manager = 'npm',
    })
  end
}
