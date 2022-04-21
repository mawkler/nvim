--------------
-- Gitsigns --
--------------
return { 'lewis6991/gitsigns.nvim',
  config = function()
    local map, feedkeys = require('../utils').map, require('../utils').feedkeys

    local gitsigns = require('gitsigns')
    require('gitsigns').setup {
      signs = {
        add          = {text = '│', hl = 'String'},
        change       = {text = '│', hl = 'Boolean'},
        changedelete = {text = '│', hl = 'Boolean'},
        delete       = {text = '▁', hl = 'Error'},
        topdelete    = {text = '▔', hl = 'Error'},
      },
      attach_to_untracked = false,
      on_attach = function()
        map({'n', 'x'}, '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>', 'Stage git hunk')
        map({'n', 'x'}, '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', 'Reset git hunk')
        map('n',        '<leader>ghS', gitsigns.stage_buffer, 'Stage entire buffer')
        map('n',        '<leader>ghR', gitsigns.reset_buffer, 'Reset entire buffer')
        map('n',        '<leader>ghu', gitsigns.undo_stage_hunk, 'Undo git hunk stage')
        map('n',        '<leader>ghp', gitsigns.preview_hunk, 'Preview git hunk')
        map('n',        '<leader>gb',  function() return gitsigns.blame_line({
          full = true,
          ignore_whitespace = true,
        }) end, 'Git blame line')

        -- Next/previous hunk
        map('n', ']c', function()
          if vim.o.diff then
            feedkeys(']c', 'n')
          else
            gitsigns.next_hunk()
          end
        end, 'Next git hunk')
        map('n', '[c', function()
          if vim.o.diff then
            feedkeys('[c', 'n')
          else
            gitsigns.prev_hunk()
          end
        end, 'Previous git hunk')

        -- Text objects
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
        map({'o', 'x'}, 'ah', gitsigns.select_hunk)
      end,
    }
    -- Workaround for bug where change highlight switches for some reason
    vim.cmd 'hi! link GitGutterChange DiffChange'
    vim.opt.diffopt:append { 'algorithm:patience' } -- Use patience diff algorithm
  end,
}
