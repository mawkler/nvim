---------------
-- Demicolon --
---------------
return {
  'mawkler/demicolon.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    keymaps = {
      horizontal_motions = false,
      disabled_keys = { 'p', 'I', 'A', 'i' },
    },
  },
}
