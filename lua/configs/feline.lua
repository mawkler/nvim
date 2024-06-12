------------
-- Feline --
------------
return {
  'freddiehaddad/feline.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/lsp-status.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local colorscheme = require('utils.colorscheme')

    local default_theme = colorscheme.get_default_feline_highlights()

    require('statusline').setup({ theme = default_theme })
    require('feline').add_theme('onedark', default_theme)

    vim.opt.laststatus = 3 -- Global statusline
  end
}
