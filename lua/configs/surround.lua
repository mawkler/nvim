--------------
-- Surround --
--------------
return { 'kylechui/nvim-surround',
  keys = {
    {'n', 's'},
    {'o', 's'},
    {'x', 's'},
    {'x', 'S'},
    {'n', 'ys'},
    {'n', 'yS'},
  },
  module = 'nvim-surround',
  setup = function()
    local map = require('utils').map
    local augroup = 'Surround'

    map('n', 'S', 's$', { remap = true, desc = 'Surround until end of line' })

    local function filetype_surround(filetype, surrounds)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetype,
        callback = function()
          require('nvim-surround').buffer_setup({
            surrounds = surrounds
          })
        end,
        group = augroup,
      })
    end

    vim.api.nvim_create_augroup(augroup, {})

    filetype_surround('lua', {
      F = { -- Anonymous function
        add = function()
          return { { 'function() return ' }, { ' end' } }
        end,

      },
    })
    filetype_surround('markdown', {
      c = { -- Code block
        add = function()
          return { { '```', ''}, { '', '```' } }
        end
      },
    })
    filetype_surround('tex', {
      c = { -- LaTeX command
        add = function()
          return {
            { '\\' .. vim.fn.input({ prompt = 'LaTex command: ' }) .. '{' },
            { '}' }
          }
        end
      },
    })
  end,
  config = function()
    local plugin_setup = require('utils').plugin_setup

    plugin_setup('nvim-surround', ({
      move_cursor = false,
      keymaps = {
        normal = 's',
        normal_cur = 'ss',
        visual = 's',
        visual_line = 'S',
      },
      aliases = {
        q = "'",
        Q = '"',
        A = '`',
      },
    }))
  end
}
