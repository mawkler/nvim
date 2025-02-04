------------------
-- Tiny Glimmer --
------------------
return {
  'rachartier/tiny-glimmer.nvim',
  lazy = true, -- This plugin gets lazy load by lua/configs/yanky.lua
  opts = {
    animations = {
      fade = {
        from_color = 'TinyGlimmerYank',
      },
    },
    overwrite = {
      paste = {
        default_animation = {
          name = 'fade',
          settings = {
            from_color = 'TinyGlimmerPaste',
          },
        },
        paste_mapping = '<Plug>(YankyPutAfter)',
        Paste_mapping = '<Plug>(YankyPutBefore)',
      },
    },
  },
}
