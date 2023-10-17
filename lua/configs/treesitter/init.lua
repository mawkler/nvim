----------------
-- Treesitter --
----------------
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  build = ':TSUpdate',
  event = 'VeryLazy',
  enabled = not vim.g.vscode,
  config = function()
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

    local special_keymaps = {
      -- Keymaps that shouldn't be prefixed with i/a
      ['<'] = '@assignment.lhs',
      ['>'] = '@assignment.rhs',
    }
    local other_keymaps = require('configs.treesitter.config').get_keymaps()
    local keymaps = vim.tbl_extend('keep', special_keymaps, other_keymaps)

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
          init_selection = "\\",
          node_incremental = "\\",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobject
          include_surrounding_whitespace = include_surrounding_whitespace,
          keymaps = keymaps,
          selection_modes = {
            -- Make `af`, `aC` and `am` line-wise
            ['@function.outer'] = 'V',
            ['@class.outer'] = 'V',
            ['@method.outer'] = 'V',
            ['@method.inner'] = 'V',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Add jumps to jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
            [']a'] = '@parameter.outer',
            [']o'] = '@loop.outer',
            [']R'] = '@return.outer',
            [']m'] = '@method.outer',
            [']N'] = '@number.outer',
            [']X'] = '@regex.outer',
            [']S'] = '@statement.outer',
            [']#'] = '@comment.outer',
            ['];'] = '@block.outer',
            [']?'] = '@conditional.outer',
            [']!'] = '@statement.outer',
            [']='] = '@assignment.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[a'] = '@parameter.outer',
            ['[o'] = '@loop.outer',
            ['[R'] = '@return.outer',
            ['[m'] = '@method.outer',
            ['[N'] = '@number.outer',
            ['[X'] = '@regex.outer',
            ['[S'] = '@statement.outer',
            ['[;'] = '@block.outer',
            ['[#'] = '@comment.outer',
            ['[?'] = '@conditional.outer',
            ['[!'] = '@statement.outer',
            ['[='] = '@assignment.outer',
          },
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
          -- TODO: use config.query_keymaps to set these and goto
          swap_next = {
            ['>aa'] = '@parameter.inner',
            ['>af'] = '@function.outer',
            ['>aC'] = '@class.outer',
          },
          swap_previous = {
            ['<aa'] = '@parameter.inner',
            ['<af'] = '@function.outer',
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
