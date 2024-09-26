---------------
-- Rest.nvim --
---------------
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
    vim.g.rest_nvim = {
      highlight = {
        timeout = 150,
      },
    }

    ---@param command string
    local function execute(command)
      return function ()
        local prefix = ''

        -- Show result below if window is too narrow
        if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 140 then
          prefix = 'horizontal rightbelow '
        end

        vim.cmd(prefix .. command)
      end
    end

    vim.api.nvim_create_user_command('Http', function()
      if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) < 80 then
        vim.cmd.wincmd('s')
      else
        vim.cmd.wincmd('v')
      end
      vim.cmd.edit('~/.local/share/nvim/rest.http')
    end, { desc = 'Send HTTP request' })

    local augroup = vim.api.nvim_create_augroup('RestNvim', {})

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'http',
      callback = function()
        local map = require('utils').map
        local opts = { buffer = true }

        vim.o.wrap = false

        map('n', '<CR>',       execute('Rest run'),       opts)
        map('n', '<leader>lr', execute('Rest last'),      opts)
        map('n', '<leader>ly', '<cmd>Rest curl yank<CR>', opts)
      end,
      group = augroup
    })
  end
}
