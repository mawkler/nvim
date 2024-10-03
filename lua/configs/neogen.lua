------------
-- Neogen --
------------
return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  version = '*',
  keys = { { '<leader>D', '<cmd>Neogen<CR>', desc = 'Generate annotations' } },
  opts = {
    snippet_engine = 'luasnip',
  }
}
