-------------
-- Incline --
-------------
return {
  'b0o/incline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'WinNew',
  config = function()
    local get_highlight = require('utils.colors').get_highlight

    require('incline').setup({
      hide = {
        focused_win = true,
        only_win = true,
      },
      window = {
        zindex = 1,
        winhighlight = {
          Normal = {
            guifg = get_highlight('Comment'),
            guibg = nil,
          },
        },
        margin = { vertical = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)
        return {
          { icon,     guifg = color },
          { ' ' },
          { filename, gui = 'italic' },
        }
      end
    })
  end
}
