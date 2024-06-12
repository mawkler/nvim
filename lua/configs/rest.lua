---------------
-- Rest.nvim --
---------------
---@diagnostic disable: missing-fields
return {
  'rest-nvim/rest.nvim',
  dependencies = {
    { 'vhyrro/luarocks.nvim', opts = {} },
  },
  cmd = { 'Rest', 'Http' },
  ft = 'http',
  -- Fix for when Neovim gets started with a *.http and leap.nvim overrides the <CR> mapping
  event = 'BufRead *.http',
  config = function()
    local map = require('utils').map
    local rest = require('rest-nvim')

    rest.setup({
      result = {
        split = {
          horizontal = true,
          in_place = true,
          stay_in_current_window_after_split = false,
        }
      },
      highlight = {
        timeout = 150,
      }
    })

    vim.api.nvim_create_user_command(
      'Http',
      function()
        if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 80 then
          vim.cmd.wincmd('s')
        else
          vim.cmd.wincmd('v')
        end
        vim.cmd.edit('~/.local/share/nvim/rest.http')
      end,
      { desc = 'Send HTTP request' }
    )

    vim.api.nvim_create_augroup('RestNvim', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        vim.o.wrap = false

        local opts = { buffer = true }
        map('n', '<CR>',       '<cmd>Rest run<CR>',      opts)
        map('n', '<leader>lr', '<cmd>Rest run last<CR>', opts)
        map('n', '<leader>ly', '<Plug>RestNvimPreview',  opts)
      end,
      group = 'RestNvim'
    })
  end
}
