-------------
-- Printer --
-------------

local function lua_formatter(inside, variable)
  return string.format("print('%s: ' .. vim.inspect(%s))", inside, variable)
end

return {
  'rareitems/printer.nvim',
  keys = 'gp',
  config = function()
    require('printer').setup({
      keymap = 'gp',
      formatters = {
        lua = lua_formatter,
      }
    })
  end
}
