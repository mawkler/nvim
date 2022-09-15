----------------
-- Toggleterm --
----------------
return { 'akinsho/toggleterm.nvim',
  keys = '<C-CR>',
  cmd = {
    'ToggleTerm',
    'ToggleTermToggleAll',
    'ToggleTermSendCurrentLine',
    'ToggleTermSendVisualLines',
    'ToggleTermSendVisualSelection',
  },
  config = function()
    local toggleterm, utils = require('toggleterm'), require('utils')
    local map = utils.map
    local api = vim.api

    toggleterm.setup {
      open_mapping = '<C-CR>',
      direction = 'float',
      float_opts = {
        border = 'curved',
        winblend = 4,
        highlights = {
          background = 'NormalFloat',
          border = 'TelescopeBorder',
        },
      },
    }

    local function go_to_file(command)
      return function()
        local cursor = api.nvim_win_get_cursor(0)
        local bufnr = api.nvim_get_current_buf()
        toggleterm.toggle(0)
        api.nvim_win_set_buf(0, bufnr)
        api.nvim_win_set_cursor(0, cursor)
        vim.cmd('norm! ' .. command)
      end
    end

    api.nvim_create_augroup('ToggleTerm', {})
    api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        map('n', 'gf', go_to_file('gf'), {
          desc = 'Close toggleterm and go to file',
          buffer = true,
        })
        map('n', 'gF', go_to_file('gF'), {
          desc = 'Close toggleterm and go to file (and line number)',
          buffer = true,
        })
      end,
      group = 'ToggleTerm'
    })
  end
}
