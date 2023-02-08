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
      local query_keymaps = require('configs.treesitter.config').query_keymaps

      return vim.tbl_map(function(query)
        return gen_spec.treesitter({
          i = query .. '.inner',
          a = query .. '.outer',
        })
      end, query_keymaps)
    end

    local custom_textobjects = vim.tbl_extend('force', ts_query_keymaps(), {
      b = pair('(', ')'),
      r = pair('[', ']'),
      q = pair("'"),
      Q = pair('"'),
      A = pair('`'),
      -- `@comment.inner` doesn't exist yet
      c = gen_spec.treesitter({ a = '@comment.outer', i = '@comment.outer' }),
    })

    require('mini.ai').setup({
      verbose = false,
      custom_textobjects = custom_textobjects,
    })
  end,
}
