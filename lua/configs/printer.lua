-------------
-- Printer --
-------------

return {
  'rareitems/printer.nvim',
  keys = 'gp',
  config = function()
    local function lua_formatter(inside, variable)
      return ("print('%s: ' .. vim.inspect(%s))"):format(inside, variable)
    end

    local function rust_formatter(inside, _)
      local function starts_with(str, substr)
        return string.sub(str, 1, 1) == substr
      end

      local prefix = starts_with(inside, '&') and '' or '&'
      return ('dbg!(%s%s);'):format(prefix, inside)
    end

    local function elixir_formatter(inside, variable)
      return ('IO.inspect(%s)'):format(inside, variable)
    end

    local function heex_formatter(inside, variable)
      return ('<%% IO.inspect(%s, pretty: true) %%>'):format(inside, variable)
    end

    require('printer').setup({
      keymap = 'gp',
      formatters = {
        lua = lua_formatter,
        rust = rust_formatter,
        elixir = elixir_formatter,
        heex = heex_formatter,
      },
      add_to_inside = function(text)
        return ('%s'):format(text)
      end,
    })

    vim.keymap.set('n', 'gpp', 'gpiL', { remap = true })
  end
}
