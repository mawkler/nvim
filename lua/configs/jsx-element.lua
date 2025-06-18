---------------------
-- jsx-element.nvm --
---------------------
return {
  'mawkler/jsx-element.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  ft = { 'typescriptreact', 'javascriptreact', 'javascript' },
  --- @type jsx-element.options
  opts = {},
}
