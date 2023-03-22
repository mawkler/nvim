---------------
-- Unception --
---------------
return {
  'samjwill/nvim-unception',
  dependencies = 'akinsho/toggleterm.nvim',
  config = function()
    vim.api.nvim_create_autocmd(
      'User',
      {
        pattern = 'UnceptionEditRequestReceived',
        callback = function()
          require('toggleterm').toggle(1)
        end
      }
    )
  end
}
