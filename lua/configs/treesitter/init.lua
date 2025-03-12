----------------
-- Treesitter --
----------------
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'brianhuster/nvim-treesitter-endwise',
  build = ':TSUpdate',
  event = 'VeryLazy',
  enabled = not vim.g.vscode,
  config = function()
    local map = require('utils').map
    local maps = require('configs.treesitter.keymaps')
    local utils = require('configs.treesitter.utils')

    local function include_surrounding_whitespace(selection)
      local queries = {
        '@function.outer',
        '@class.outer',
        '@parameter.outer',
        '@block.outer',
      }
      return vim.tbl_contains(queries, selection.query_string)
    end

    local special_keymaps = {
      -- Keymaps that shouldn't be prefixed with i/a
      ['<']  = '@assignment.lhs',
      ['>']  = '@assignment.rhs',
      ['iK'] = '@assignment.lhs',
      ['iV'] = '@assignment.rhs',
      ['i;'] = '@comment.outer',   -- @comment.inner isn't implemented yet
      ['iS'] = '@statement.outer', -- @statement.inner isn't implemented yet
    }
    local keymaps = maps.get_textobj_keymaps(special_keymaps)

    -- Reset `>>`/`<<` mappings to not be @assignment
    map('n', '>>', '>>')
    map('n', '<<', '<<')

    local special_goto_next_start = { [']]'] = '@class.outer' }
    local special_goto_prev_start = { ['[['] = '@class.outer' }
    local goto_next_start = maps.get_motion_keymaps(']', special_goto_next_start)
    local goto_previous_start = maps.get_motion_keymaps('[', special_goto_prev_start)

    local special_swap_next = { ['>aa'] = '@parameter.inner' }
    local special_swap_prev = { ['<aa'] = '@parameter.inner' }
    local swap_next = maps.get_textobj_swap_keymaps('>', special_swap_next)
    local swap_previous = maps.get_textobj_swap_keymaps('<', special_swap_prev)

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = {
        enable = true,
        disable = { 'latex', 'gitcommit' },
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '\\',
          node_incremental = '\\',
          node_decremental = '<BS>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobject
          include_surrounding_whitespace = include_surrounding_whitespace,
          keymaps = keymaps,
        },
        move = {
          enable = true,
          set_jumps = true, -- Add jumps to jumplist
          goto_next_start = goto_next_start,
          goto_previous_start = goto_previous_start,
          goto_next_end = {
            [']F'] = '@function.outer',
            [']['] = '@class.outer',
            [']A'] = '@parameter.outer',
            [']K'] = '@block.outer',
            ['[M'] = '@method.outer'
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[A'] = '@parameter.outer',
            ['[K'] = '@block.outer',
            ['[M'] = '@method.outer'
          }
        },
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_previous,
        },
      },
      matchup = {
        enable = true,
        disable_virtual_text = true,
        include_match_words = true
      },
      endwise = { enable = true },
      context_commentstring = {
        config = {
          javascript = {
            __default = '// %s',
            jsx_element = '{/* %s */}',
            jsx_fragment = '{/* %s */}',
            jsx_attribute = '// %s',
            comment = '// %s',
          },
          typescript = {
            __default = '// %s',
            __multiline = '/* %s */',
          },
        },
      },
    })

    utils.filetype_keymaps('rust', {
      t = { node = 'class', name = 'type' },
    })

    utils.filetype_excluding_keymaps({ 'markdown', 'txt', 'tex', 'html' }, {
      s = { node = 'statement' },
    })

    local jsx_filetypes = { 'typescriptreact', 'javascript', 'javascriptreact' }
    utils.filetype_keymaps(jsx_filetypes, {
      t = { node = 'jsx_element' },
    })

    -- Prints the syntax highlighting values under cursor
    map('n', '<leader>H', '<cmd>Inspect<CR>')

    -- Disable treesitter from highlighting errors (LSP does that anyway)
    vim.api.nvim_set_hl(0, 'TSError', { link = 'Normal' })
  end
}
