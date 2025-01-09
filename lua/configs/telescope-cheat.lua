--------------------
-- Telescope chat --
--------------------

local function cheat()
  require('telescope').extensions.cheat.fd({})
end

return {
  'nvim-telescope/telescope-cheat.nvim',
  dependencies = {
    'kkharji/sqlite.lua',
    'nvim-telescope/telescope.nvim'
  },
  keys = {
    {
      mode = 'n',
      '<leader>tC',
      cheat,
      desc = 'Cheat.sh',
    },
  },
  config = function()
    require('telescope').load_extension('cheat')
  end
}
