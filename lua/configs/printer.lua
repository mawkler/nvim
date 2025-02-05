-------------
-- Printer --
-------------

return {
  'rareitems/printer.nvim',
  keys = 'gp',
  config = function()
    local function lua_formatter(inside, variable)
      return string.format("print('%s: ' .. vim.inspect(%s))", inside, variable)
    end

    local function rust_formatter(inside, _)
      local function starts_with(str, substr)
        return string.sub(str, 1, 1) == substr
      end

      local prefix = starts_with(inside, '&') and '' or '&'
      return string.format('dbg!(%s%s);', prefix, inside)
    end

    local function elixir_formatter(inside, variable)
      return string.format('IO.inspect(%s)', inside, variable)
    end

    local function heex_formatter(inside, variable)
      return string.format('<%% IO.inspect(%s, pretty: true) %%>', inside, variable)
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
        return string.format('%s', text)
      end,
    })

    vim.keymap.set('n', 'gpp', 'gpiL', { remap = true })
  end
}
