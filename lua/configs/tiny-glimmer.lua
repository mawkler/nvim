------------------
-- Tiny Glimmer --
------------------
return {
  'rachartier/tiny-glimmer.nvim',
  lazy = true, -- This plugin gets lazy load by lua/configs/yanky.lua
  config = function()
    local get_highlight = require('utils.colors').get_highlight

    local highlights = {
      Yank = 'String',
      Paste = 'Keyword',
      Substitute = 'Statement',
    }

    for name, hl in pairs(highlights) do
      local fg = get_highlight(hl, 'fg')
      vim.api.nvim_set_hl(0, 'TinyGlimmer' .. name, { bg = fg, default = true })
    end

    require('tiny-glimmer').setup({
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
      support = {
        substitute = {
          enabled = true,
          default_animation = {
            name = 'fade',
            settings = {
              from_color = 'TinyGlimmerSubstitute',
            },
          },
        },
      },
    })
  end,
}
