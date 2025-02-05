--------------------
-- nvim-colorizer --
--------------------
return {
  'NvChad/nvim-colorizer.lua',
  event = 'VeryLazy',
  opts = {
    filetypes = { '*', '!lazy' },
    user_default_options = {
      names = false,
    }
  }
}
