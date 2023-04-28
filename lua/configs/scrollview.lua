----------------
-- Scrollview --
----------------
return {
  'dstein64/nvim-scrollview',
  event = 'WinScrolled',
  config = function()
    local scrollview = require('scrollview')

    scrollview.setup({
      current_only = true,
      winblend = 50,
    })

    local augroup = vim.api.nvim_create_augroup('Scrollview', {})
    vim.api.nvim_create_autocmd({ 'WinScrolled' }, {
      group = augroup,
      callback = scrollview.scrollview_enable,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      group = augroup,
      callback = scrollview.scrollview_disable,
    })
  end
}
