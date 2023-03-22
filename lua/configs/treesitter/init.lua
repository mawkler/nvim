----------------
-- Treesitter --
----------------
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  build = ':TSUpdate',
  config = function ()
    local map = require('utils').map

    local function include_surrounding_whitespace(selection)
      local queries = {
        '@function.outer',
        '@class.outer',
        '@parameter.outer',
        '@block.outer',
      }
      return vim.tbl_contains(queries, selection.query_string)
    end

    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = {
        enable = true,
        disable = { 'latex', 'vim', 'gitcommit' },
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobject
          include_surrounding_whitespace = include_surrounding_whitespace,
          keymaps = require('configs.treesitter.config').get_keymaps(),
          selection_modes = {
            -- Make `aF` and `aC` line-wise
            ['@function.outer'] = 'V',
            ['@class.outer'] = 'V',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Add jumps to jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
            [']a'] = '@parameter.outer',
            [']c'] = '@comment.outer',
            [']i'] = '@conditional.outer',
            [']o'] = '@loop.outer',
            [']k'] = '@block.outer',
            [']R' ] = '@return.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[a'] = '@parameter.outer',
            ['[c'] = '@comment.outer',
            ['[i'] = '@conditional.outer',
            ['[k'] = '@block.outer',
            ['[R'] = '@return.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']['] = '@class.outer',
            [']A'] = '@parameter.outer',
            [']I'] = '@conditional.outer',
            [']K'] = '@block.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[A'] = '@parameter.outer',
            ['[I'] = '@conditional.outer',
            ['[K'] = '@block.outer',
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ['>aa'] = '@parameter.inner',
            ['>aF'] = '@function.outer',
            ['>aC'] = '@class.outer',
          },
          swap_previous = {
            ['<aa'] = '@parameter.inner',
            ['<aF'] = '@function.outer',
            ['<aC'] = '@class.outer',
          },
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      matchup = {
        enable = true,
        disable_virtual_text = true,
        include_match_words = true
      },
    })

    -- Prints the syntax highlighting values under cursor
    map('n', '<leader>H', '<cmd>Inspect<CR>')

    -- Disable treesitter from highlighting errors (LSP does that anyway)
    vim.api.nvim_set_hl(0, 'TSError', { link = 'Normal' })
  end
}
