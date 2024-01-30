---------------
-- Text-case --
---------------
return {
  'johmsalas/text-case.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    'gA',
    { 'gA.', '<cmd>TextCaseOpenTelescope<CR>', mode = { 'n', 'x' }, desc = 'Text case telescope' },
  },
  cmd = 'Subs',
  config = function()
    require('textcase').setup({
      default_keymappings_enabled = true,
      prefix = 'gA',
    })

    require('telescope').load_extension('textcase')
  end
}
