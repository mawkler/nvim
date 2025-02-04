------------------
-- Tiny Glimmer --
------------------
return {
    'rachartier/tiny-glimmer.nvim',
    lazy = true, -- This plugin gets lazy load by lua/configs/yanky.lua
    opts = {
        animations = {
            fade = {
                from_color = 'IncSearch',
            },
        },
        overwrite = {
            paste = {
                default_animation = 'fade',
                paste_mapping = '<Plug>(YankyPutAfter)',
                Paste_mapping = '<Plug>(YankyPutBefore)',
            },
        },
    },
}
