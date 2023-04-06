---------------
-- Catpuccin --
---------------
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
    })
    -- vim.api.nvim_command 'colorscheme catppuccin'
  end
}
