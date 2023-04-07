---------------
-- Catpuccin --
---------------
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      custom_highlights = function(colors)
        return {
          NormalMode  = { fg = colors.green },
          InsertMode  = { fg = colors.blue },
          VisualMode  = { fg = colors.mauve },
          CommandMode = { fg = colors.red },
          SelectMode  = { fg = colors.sky },
          ReplaceMode = { fg = colors.maroon },
          TermMode    = { fg = colors.green },
        }
      end
    })
  end
}
