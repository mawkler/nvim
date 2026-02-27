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

    -- Opens the file under the cursor in the previous window
    local function go_to_file()
      local filepath = vim.fn.expand('<cfile>')
      local line_text = vim.api.nvim_get_current_line()

      -- Start and end columns for `filepath`
      local start_col, end_col = string.find(line_text, filepath, 1, true)
      if not start_col then
        return
      end

      -- `<cfile>` doesn't include colon suffixed lines or columns
      local rest_of_line = line_text:sub(end_col + 1)
      local line_nr, col_nr = string.match(rest_of_line, '^:(%d+):?(%d*)')

      line_nr = (line_nr and line_nr ~= '') and (':%s'):format(line_nr) or ''
      col_nr  = (col_nr and col_nr ~= '') and (':%s'):format(col_nr) or ''

      local path = filepath .. line_nr .. col_nr
      if #api.nvim_tabpage_list_wins(0) == 1 then
        vim.cmd('leftabove vsplit ' .. vim.fn.fnameescape(path))
      else
        vim.cmd.wincmd('p')
        vim.cmd.edit(path)
      end
    end

    local augroup = api.nvim_create_augroup('ToggleTerm', {})
    api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function(event)
        local map = require('utils').local_map(event.buf)

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
