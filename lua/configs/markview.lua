--------------
-- Markview --
--------------
return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Markview handles lazy loading
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local markview = require('markview')
    local no_padding = { add_padding = false }

    local custom_hyperlinks = {
      { match = '[%.]md$', icon = ' ' },
      { match = '^#', icon = ' ' },
      { match = '^%./', icon = ' ' },
      { match = 'https://(.+)$', icon = '󰌷 ' },
      { match = 'http://(.+)$', icon = '󰌸 ' },
    }

    local function add_hl_to_hyperlinks(hyperlinks)
      local hyperlinks_with_hl = {}
      for i, hyperlink in pairs(hyperlinks) do
        local hl = { hl = 'MarkviewHyperlink' }
        hyperlinks_with_hl[i] = vim.tbl_deep_extend('keep', hyperlink, hl)
      end
      return hyperlinks_with_hl
    end

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
          icon = ' ',
          custom = add_hl_to_hyperlinks(custom_hyperlinks)
        },
      }
    }

    markview.configuration = vim.tbl_deep_extend('force', markview.configuration, config)
  end
}
