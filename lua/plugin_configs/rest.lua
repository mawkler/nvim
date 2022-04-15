---------------
-- Rest.nvim --
---------------
local map, autocmd = require('../utils').map, require('../utils').autocmd

require('rest-nvim').setup()

function _G.http_request()
  if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 80 then
    vim.cmd('wincmd s')
  else
    vim.cmd('wincmd v')
  end
  vim.cmd('edit ~/.config/nvim/http | set filetype=http | set buftype=')
end

vim.cmd 'command! Http call v:lua.http_request()'

autocmd('FileType', {
  pattern = 'http',
  callback = function()
    map('n', '<CR>', '<Plug>RestNvim:w<CR>', { buffer = true })
    map('n', '<Esc>', '<cmd>BufferClose<CR><cmd>wincmd c<CR>', { buffer = true })
  end,
  group = 'RestNvim'
})
