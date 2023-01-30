------------------------
-- Treesitter context --
------------------------
return { 'nvim-treesitter/nvim-treesitter-context',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('treesitter-context').setup({
      max_lines = 3,
    })
  end
}
