---------------
-- Rest.nvim --
---------------
return {
  'NTBBloodbath/rest.nvim',
  cmd = 'Http',
  ft = 'http',
  config = function()
    local map = require('utils').map

    require('rest-nvim').setup()

    vim.api.nvim_create_user_command(
      'Http',
      function()
        if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 80 then
          vim.cmd.wincmd('s')
        else
          vim.cmd.wincmd('v')
        end
        vim.cmd.edit('~/.config/nvim/http')
        vim.o.filetype = 'http'
        vim.o.buftype = ''

        map('n', '<Esc>', '<cmd>BufferClose<CR><cmd>wincmd c<CR>', {
          buffer = true,
        })
      end,
      { desc = 'Send HTTP request' }
    )

    vim.api.nvim_create_augroup('RestNvim', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        vim.o.wrap = false

        map('n', '<CR>', '<cmd>w<CR><Plug>RestNvim', { buffer = true, silent = true })
      end,
      group = 'RestNvim'
    })
  end
}
