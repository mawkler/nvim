------------------
-- Tiny Glimmer --
------------------
return {
  'rachartier/tiny-glimmer.nvim',
  lazy = true,             -- Gets lazy load by lua/configs/yanky.lua on paste/yank
  keys = { 'u', '<c-r>' }, -- ...or on one of these keys
  config = function()
    local get_highlight = require('utils.colors').get_highlight

    local highlights = {
      Yank = { fg = 'String' },
      Paste = { fg = 'Keyword' },
      Substitute = { fg = 'Statement' },
      Undo = { fg = 'DiffDelete' },
      Redo = { fg = 'Number' },
    }

    for name, hl in pairs(highlights) do
      local part = hl.fg and 'fg' or 'bg'
      local fg = get_highlight(hl[part], part)
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
        },
        undo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = 'TinyGlimmerUndo',
            },
          },
        },
        redo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = 'TinyGlimmerRedo',
            },
          },
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
