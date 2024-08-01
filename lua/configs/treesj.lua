------------
-- TreeSJ --
------------
local function toggle()
  require('treesj').toggle()
end

return {
  'Wansmer/treesj',
  dependencies = 'nvim-treesitter',
  keys = {
    { 'gS', toggle, desc = 'Split text-object into multiple lines' },
  },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      max_join_length = 500,
    })
  end
}
