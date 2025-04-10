-------------
-- mini.ai --
-------------
return {
  'echasnovski/mini.ai',
  dependencies = {
    'tpope/vim-repeat',
    'nvim-treesitter/nvim-treesitter'
  },
  version = '*',
  event = 'VeryLazy',
  config = function()
    local gen_spec = require('mini.ai').gen_spec
    local spec_pair = gen_spec.pair

    local function pair(left, right)
      if right == nil then
        right = left
      end

      return spec_pair(left, right, { type = 'balanced' })
    end

    local function ts_query_keymaps()
      local keymaps = require('configs.treesitter.keymaps').keymaps

      return vim.tbl_map(function(capture)
        return gen_spec.treesitter({
          i = capture .. '.inner',
          a = capture .. '.outer',
        })
      end, keymaps)
    end

    local custom_textobjects = vim.tbl_extend('force', ts_query_keymaps(), {
      b = pair('(', ')'),
      B = pair('{', '}'),
      r = pair('[', ']'),
      q = pair("'"),
      Q = pair('"'),
      A = pair('`'),
      [';'] = gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
    })

    require('mini.ai').setup({
      verbose = false,
      custom_textobjects = custom_textobjects,
      n_lines = 500, -- Number of lines where textobject is searched for
    })
  end,
}
