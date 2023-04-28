---------------
-- Unception --
---------------
return {
  'samjwill/nvim-unception',
  dependencies = 'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  init = function()
    vim.g.unception_enable_flavor_text = false
  end,
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
