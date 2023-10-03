---------------
-- Rest.nvim --
---------------
return {
  'NTBBloodbath/rest.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  cmd = 'Http',
  ft = 'http',
  -- Fix for when Neovim gets started with a *.http and leap.nvim overrides the <CR> mapping
  event = 'BufRead *.http',
  config = function()
    local map = require('utils').map
    local rest = require('rest-nvim')

    rest.setup({
      result_split_horizontal = true,
      result_split_in_place = true,
    })

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
      end,
      { desc = 'Send HTTP request' }
    )

    vim.api.nvim_create_augroup('RestNvim', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        vim.o.wrap = false

        local opts = { buffer = true }
        map('n', '<CR>',       rest.run,                opts)
        map('n', '<leader>lr', rest.last,               opts)
        map('n', '<leader>ly', '<Plug>RestNvimPreview', opts)
      end,
      group = 'RestNvim'
    })
  end
}
