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
    local get_selections = require('nvim-surround.config').get_selections
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
      return {
        add = function()
          return { { name .. '<' }, { '>' } }
        end,
        delete = function(char)
          return get_selections({
            char = char,
            pattern = string.format('(%s<)().-(>)()', name),
          })
        end,
      }
    end

    ---@return { add: function, delete: function }
    local function function_name(name)
      return {
        add = function()
          return { { name .. '(' }, { ')' } }
        end,
        delete = function(char)
          return get_selections({
            char = char,
            pattern = string.format('(%s%()().-(%))()', name),
          })
        end,
      }
    end


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
        end,
        delete = function(char)
          return get_selections({
            char = char,
            pattern = '(```[a-zA-Z]*\n)().-(```\n)()',
          })
        end,
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
      v = { -- vec![]
        add = function()
          return { { 'vec![' }, { ']' } }
        end,
        delete = function(char)
          return get_selections({
            char = char,
            pattern = '(vec!%[)().-(%])()',
          })
        end,
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
