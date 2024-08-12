---------------
-- Demicolon --
---------------
return {
  'mawkler/demicolon.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  keys = { 't', 'f', 'T', 'F', ']', '[' },
  config = function()
    local demicolon = require('demicolon')
    local map = require('utils').map

    demicolon.setup({
      keymaps = {
        horizontal_motions = false,
      },
      diagnostic = {
        float = {
          border = 'rounded',
        },
      },
    })

    local function eyeliner_jump(key)
      local forward = vim.list_contains({ 't', 'f' }, key)
      return function()
        require('eyeliner').highlight({ forward = forward })
        return require('demicolon.jump').horizontal_jump_repeatably(key)()
      end
    end

    local nxo = { 'n', 'x', 'o' }
    local opts = { expr = true }

    map(nxo, 'f', eyeliner_jump('f'), opts)
    map(nxo, 'F', eyeliner_jump('F'), opts)
    map(nxo, 't', eyeliner_jump('t'), opts)
    map(nxo, 'T', eyeliner_jump('T'), opts)
  end,
}
