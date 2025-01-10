--------------
-- Surround --
--------------
return {
  'kylechui/nvim-surround',
  keys = {
    { 's',  mode = { 'n', 'x', 'o' } },
    { 'S',  mode = 'x' },
    { 'ds', mode = 'n'  },
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

    ---@return { add: function, delete: function }
    local function type(name)
      local regex = string.format('(%s<)().-(>)()', name)
      return {
        add = function()
          return { { name .. '<' }, { '>' } }
        end,
        find = regex,
        delete = regex,
      }
    end

    ---@return { add: function, delete: function }
    local function function_name(name)
      local regex = '(' .. name .. '%()().-(%))()'
      return {
        add = function()
          return { { name .. '(' }, { ')' } }
        end,
        find = regex,
        delete = regex,
      }
    end

    filetype_surround('lua', {
      F = { -- Anonymous function
        add = function()
          return { { 'function() return ' }, { ' end' } }
        end,
        find = '^(.-function.-%b())().*(end)()$',
        delete = '^(.-function.-%b())().*(end)()$',
      },
    })
    filetype_surround('markdown', {
      c = { -- Code block
        add = function()
          return { { '```', ''}, { '', '```' } }
        end,
        find = '(```[a-zA-Z]*\n)().-(\n```)()',
        delete = '(```[a-zA-Z]*\n)().-(\n```)()',
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
        end,
        find = '([A-Za-z]+<)().-(>)()',
        delete = '([A-Za-z]+<)().-(>)()',
      },
      v = { -- vec![]
        add = function()
          return { { 'vec![' }, { ']' } }
        end,
        find = '(vec!%[)().-(%])()',
        delete = '(vec!%[)().-(%])()',
      },
      s = function_name('Some'),
      o = function_name('Ok'),
      O = type('Option'),
      R = type('Result'),
      V = type('Vec'),
    })
    filetype_surround({ 'typescript', 'javascript' }, {
      s = { -- String interpolation
        add = function()
          return { { '${' }, { '}' } }
        end,
      },
    })
  end,
  config = function()
    require('nvim-surround').setup({
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
    })
  end
}
