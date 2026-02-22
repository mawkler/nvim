---------------
-- Dev tools --
---------------

return {
  'yarospace/dev-tools.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'ThePrimeagen/refactoring.nvim',
  },
  keys = '<leader>a',
  opts = {
    builtin_actions = {
      exclude = { 'Specs', 'Todo', 'Debugging' },
    },
  }
}
