------------
-- Neogen --
------------
return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  version = '*',
  keys = { { '<leader>D', '<cmd>Neogen<CR>', desc = 'Generate annotations' } },
  config = {
    snippet_engine = 'luasnip',
  }
}
