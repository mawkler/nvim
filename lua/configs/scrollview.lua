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
      signs_on_startup = {}, -- Disable scrollview diagnostics
    })

    local augroup = vim.api.nvim_create_augroup('Scrollview', {})
    vim.api.nvim_create_autocmd({ 'WinScrolled' }, {
      group = augroup,
      callback = function() scrollview.set_state(true) end,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      group = augroup,
      callback = function()
        -- Scrollview throws an error in command-line window for some reason
        if vim.fn.win_gettype() ~= 'command' then
          scrollview.set_state(false)
        end
      end,
    })
  end
}
