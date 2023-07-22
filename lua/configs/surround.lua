--------------
-- Surround --
--------------
return {
  'kylechui/nvim-surround',
  keys = {
    { 's', mode = { 'n', 'x', 'o' } },
    { 'S', mode = 'x' },
  },
  init = function()
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
    filetype_surround({ 'rust', 'typescript' }, {
      T = { -- Type
        add = function()
          return {
            { vim.fn.input({ prompt = 'Type name: ' }) .. '<' }, { '>' }
          }
        end
      },
    })
    filetype_surround({ 'typescript' }, {
      s = { -- String interpolation
        add = function()
          return { { '${' }, { '}' } }
        end
      },
    })
  end,
  config = function()
    require('nvim-surround').setup({
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
    })
  end
}
