------------
-- Feline --
------------

-- Disable statusline until feline has been loaded (reduces Firenvim flickering)
vim.o.laststatus = 0

return {
  'second2050/feline.nvim',
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

    -- Global statusline (disabled for Firenvim)
    if not vim.g.started_by_firenvim then
      vim.opt.laststatus = 3
    end
  end
}
