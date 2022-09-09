---------------
-- Rest.nvim --
---------------
return { 'NTBBloodbath/rest.nvim',
  cmd = 'Http',
  config = function()
    local map, plugin_setup = require('utils').map, require('utils').plugin_setup

    plugin_setup('rest-nvim')

    local function http_request()
      if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 80 then
        vim.cmd('wincmd s')
      else
        vim.cmd('wincmd v')
      end
      vim.cmd('edit ~/.config/nvim/http | set filetype=http | set buftype=')
    end

    vim.api.nvim_create_user_command('Http', http_request, {
      desc = 'Send HTTP request',
    })

    vim.api.nvim_create_augroup('RestNvim', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        vim.o.wrap = false

        map('n', '<CR>',  '<Plug>RestNvim:w<CR>', { buffer = true })
        map('n', '<Esc>', '<cmd>BufferClose<CR><cmd>wincmd c<CR>', {
          buffer = true,
        })
      end,
      group = 'RestNvim'
    })
  end
}
