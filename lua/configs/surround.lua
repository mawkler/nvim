--------------
-- Surround --
--------------
return { 'kylechui/nvim-surround',
  keys = {
    {'n', 's'},
    {'n', 'S'},
    {'n', 'ds'},
    {'n', 'cs'},
    {'x', 's'},
    {'x', 'S'},
  },
  module = 'nvim-surround',
  setup = function()
    local augroup = 'Surround'
    local function filetype_surround(filetype, pairs)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetype,
        callback = function()
          require('nvim-surround').buffer_setup({
            delimiters = { pairs = pairs }
          })
        end,
        group = augroup,
      })
    end

    vim.api.nvim_create_augroup(augroup, {})

    filetype_surround('lua', {
      F = { 'function() return ', ' end' }
    })
    filetype_surround('markdown', {
      c = { { '```', '' }, { '', '```' } },
    })
    filetype_surround('tex', {
      c = function()
        return {
          '\\' .. vim.fn.input({ prompt = 'LaTex command: ' }) .. '{', '}'
        }
      end,
    })
  end,
  config = function()
    local map = require('utils').map

    require('nvim-surround').setup({
      move_cursor = false,
      keymaps = {
        normal = 's',
        normal_cur = 'ss',
        visual = 's',
        visual_line = 'S',
      },
      delimiters = {
        aliases = {
          q = "'",
          Q = '"',
          A = '`',
        },
        pairs = {
          b = { '(', ')' },
          B = { '{', '}' },
          s = { ')', ']', '}', '>', '"', "'", '`' },
        },
        separators = {
          ['*'] = { '*', '*' }, -- Doesn't work yet
        },
        invalid_key_behavior = function(char)
          return { char, char }
        end,
      },
    })

    map('n', 'S', 's$', { remap = true })
  end
}
