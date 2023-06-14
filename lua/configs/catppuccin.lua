---------------
-- Catppuccin --
---------------
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  event = 'VeryLazy',
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      custom_highlights = function(colors)
        return {
          CursorLineNr = { link = 'NormalMode' },
          NormalMode   = { fg = colors.green, style = { 'bold' } },
          InsertMode   = { fg = colors.blue },
          VisualMode   = { fg = colors.mauve },
          CommandMode  = { fg = colors.red },
          SelectMode   = { fg = colors.sky },
          ReplaceMode  = { fg = colors.maroon },
          TermMode     = { fg = colors.green },
        }
      end
    })
  end
}
