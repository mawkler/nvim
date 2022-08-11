----------------
-- Possession --
----------------
return { 'jedrzejboczar/possession.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  after = { 'vim-startify' },
  module_pattern = 'possession',
  config = function()
    require('possession').setup({
      session_dir = vim.g.startify_session_dir
    })
  end
}
