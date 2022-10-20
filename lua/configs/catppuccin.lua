return { 'catppuccin/nvim',
  as = 'catppuccin',
  config = function()
	vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
	require('catppuccin').setup()
	vim.api.nvim_command 'colorscheme catppuccin'
  end
}
