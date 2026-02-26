----------------
-- Toggleterm --
----------------
return {
  'akinsho/toggleterm.nvim',
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

    toggleterm.setup({
      open_mapping = '<C-CR>',
      direction = 'vertical',
      insert_mappings = false,
      persist_mode = true,
      shading_factor = -10,
      float_opts = {
        border = 'curved',
        winblend = 4,
        highlights = {
          background = 'NormalFloat',
          border = 'TelescopeBorder',
        },
      },
      size = function()
        return vim.o.columns * 0.5
      end,
    })

    ---@param cmd string
    ---@return string
    local function in_normal_mode(cmd)
      return ([[<C-\><C-n>%s]]):format(cmd)
    end

    local augroup = api.nvim_create_augroup('ToggleTerm', {})
    api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        vim.o.cursorline = false

        map('n', 'gf',      go_to_file)
        map('n', 'gF',      go_to_file)
        map('t', '<C-w>',   in_normal_mode('<C-w>'))
        map('t', '<M-p>',   in_normal_mode('pa'))
        map('t', '<M-S-p>', in_normal_mode('"+pa'))
        map('n', '<CR>',    'A<CR>')

        map('n', '<Esc>', '', { buffer = true }) -- Don't close the window on `Esc`
      end,
      group = augroup
    })
  end
}
