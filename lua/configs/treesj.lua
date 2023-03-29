------------
-- TreeSJ --
------------
local function toggle()
  require('treesj').toggle()
end

return {
  'Wansmer/treesj',
  requires = { 'nvim-treesitter' },
  keys = {
    { 'gS', toggle, desc = 'Split text-object into multiple lines' },
  },
  config = function()
    require('treesj').setup({
      use_default_keymaps = true,
      max_join_length = 500,
    })
  end
}