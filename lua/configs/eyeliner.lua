--------------
-- Eyeliner --
--------------
return {
  'jinh0/eyeliner.nvim',
  keys = { 't', 'f', 'T', 'F' },
  config = function()
    require('eyeliner').setup({
      highlight_on_key = true,
      dim = true,
      default_keymaps = false,
    })

    local function eyeliner_jump(key)
      local forward = vim.list_contains({ 't', 'f' }, key)
      return function()
        require('eyeliner').highlight({ forward = forward })
        return require('demicolon.jump').horizontal_jump(key)()
      end
    end

    local map, nxo, opts = vim.keymap.set, { 'n', 'x', 'o' }, { expr = true }

    map(nxo, 'f', eyeliner_jump('f'), opts)
    map(nxo, 'F', eyeliner_jump('F'), opts)
    map(nxo, 't', eyeliner_jump('t'), opts)
    map(nxo, 'T', eyeliner_jump('T'), opts)
  end
}
