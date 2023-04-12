--------------------
-- scrollbar.nvim --
--------------------
return {
  'Xuyuanp/scrollbar.nvim',
  event = 'WinScrolled',
  init = function()
  end,
  config = function()
    local scrollbar = require('scrollbar')

    vim.g.scrollbar_right_offset = 0
    vim.g.scrollbar_excluded_filetypes = { 'NvimTree' }
    vim.g.scrollbar_highlight = {
      head = 'Scrollbar',
      body = 'Scrollbar',
      tail = 'Scrollbar',
    }
    vim.g.scrollbar_shape = {
      head = '▖',
      body = '▌',
      tail = '▘',
    }

    local augroup = vim.api.nvim_create_augroup('Scrollbar', {})
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'WinScrolled' }, {
      group = augroup,
      callback = function() return scrollbar.show() end,
    })
    vim.api.nvim_create_autocmd({
      'CursorHold',
      'BufLeave',
      'FocusLost',
      'VimResized',
      'QuitPre',
    }, {
      group = augroup,
      callback = scrollbar.clear,
    })
  end
}
