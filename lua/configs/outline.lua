-------------
-- Outline --
-------------
return {
  'hedyhli/outline.nvim',
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>U', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  config = function()
    local outline_icons = require('outline.config').defaults.symbols.icons

    local new_icons = {}
    for name, icon in pairs(require('utils.icons').icons) do
      new_icons[name] = { icon = icon }
    end

    require('outline').setup({
      symbols = {
        icons = vim.tbl_deep_extend('force', outline_icons, new_icons),
      },
    })
  end
}
