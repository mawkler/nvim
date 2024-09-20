--------------
-- Markview --
--------------
return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Markview handles lazy loading
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local markview = require('markview')
    local no_padding = { add_padding = false }

    local config = {
      code_blocks = {
        sign = false,
        pad_amount = 1,
      },
      tables = {
        use_virt_lines = true,
      },
      list_items = {
        marker_minus = {
          add_padding = false,
          text = '󰧞',
          hl = '@punctuation.bracket'
        },
        marker_plus = no_padding,
        marker_star = no_padding,
        marker_dot = no_padding,
      },
      checkboxes = {
        enabled = false,
        checked = {
          text = ' ',
          hl = '@text.todo.checked',
        },
        unchecked = {
          text = ' ',
          hl = '@text.todo.unchecked',
        },
      },
      links = {
        hyperlinks = {
          icon = '󰈔 ',
          custom = {
            { match = '[%.]md$', icon = ' ' },
            { match = '^#', icon = ' ' },
            { match = '^%./', icon = ' ' },
            { match = 'https://(.+)$', icon = '󰌷 ' },
            { match = 'http://(.+)$', icon = '󰌸 ' },
            { match = '[a-zA-Z]+://', icon = ' ' },
          }
        },
      }
    }

    local color_utils = require('utils.colors')
    local bg = color_utils.get_highlight('Normal', 'bg')

    local function create_highlight(hl_name, color)
      local color_mix = require('utils.colors').mix_colors(color, bg, 0.15, 0.5)
      vim.api.nvim_set_hl(0, hl_name, { fg = color, bg = color_mix, bold = true })
    end

    -- Position in table is the heading number
    local highlights = {
      '@markup.heading',
      'CursorLineNr',
      'Keyword',
      'Type',
      'Boolean',
      'Directory',
      'Cursor',
      'Statement',
      'ErrorMsg',
    }

    for i, hl in ipairs(highlights) do
      local markview_hl_name = 'MarkviewHeading' .. i
      local ts_hl_name = '@markup.heading.' .. i ..'.markdown'
      local fg = color_utils.get_highlight(hl, 'fg')

      create_highlight(markview_hl_name, fg)
      create_highlight(ts_hl_name, fg)

      if i <= 6  then
        vim.api.nvim_set_hl(0, markview_hl_name .. 'Sign', { fg = fg })
      end
    end

    markview.configuration = vim.tbl_deep_extend('force', markview.configuration, config)
  end
}
