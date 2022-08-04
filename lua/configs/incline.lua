-------------
-- Incline --
-------------
return {
  'b0o/incline.nvim',
  requires = { 'ful1e5/onedark.nvim', 'kyazdani42/nvim-web-devicons' },
  config = function()
    local colors = require('onedark').get_colors()

    require('incline').setup({
      hide = {
        focused_win = true,
        only_win = true,
      },
      window = {
        winhighlight = {
          Normal = {
            guifg = colors.fg_dark,
            guibg = nil,
          },
        },
        margin = {
          vertical = 0,
        }
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)
        return {
          { icon, guifg = color },
          { ' ' },
          { filename, gui = 'italic' },
        }
      end
    })
  end
}
