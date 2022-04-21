----------------
-- Treesitter --
----------------
return { 'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function ()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = {'latex', 'vim', 'markdown'},
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            ['aF'] = '@function.outer',
            ['iF'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[]'] = '@class.outer',
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ['>,'] = '@parameter.inner',
          },
          swap_previous = {
            ['<,'] = '@parameter.inner',
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
    }

    -- Disable treesitter from highlighting errors (LSP does that anyway)
    vim.cmd 'highlight! link TSError Normal'
  end
}
