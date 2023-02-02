--------------
-- Gitsigns --
--------------
return { 'lewis6991/gitsigns.nvim',
  dependencies = 'tpope/vim-repeat',
  config = function()
    local map, feedkeys = require('utils').map, require('utils').feedkeys
    local gitsigns = require('gitsigns')

    gitsigns.setup({
      signs = {
        add          = {text = '│'},
        change       = {text = '│'},
        changedelete = {text = '│'},
        delete       = {text = '▁'},
        topdelete    = {text = '▔'},
      },
      attach_to_untracked = false,
      trouble = false,
      on_attach = function()

        local function git_blame()
          gitsigns.blame_line({
            full = true,
            ignore_whitespace = true,
          })
        end

        map({'n', 'x'}, '<leader>ghs', gitsigns.stage_hunk, 'Stage git hunk')
        map({'n', 'x'}, '<leader>ghr', gitsigns.reset_hunk, 'Reset git hunk')

        map('n', '<leader>ghS', gitsigns.stage_buffer,    'Stage entire buffer')
        map('n', '<leader>ghR', gitsigns.reset_buffer,    'Reset entire buffer')
        map('n', '<leader>ghu', gitsigns.undo_stage_hunk, 'Undo git hunk stage')
        map('n', '<leader>ghp', gitsigns.preview_hunk,    'Preview git hunk')
        map('n', 'gb',          git_blame,                'Git blame line')

        local function next_hunk()
          if vim.o.diff then
            feedkeys(']c', 'n')
          else
            gitsigns.next_hunk()
          end
        end

        local function prev_hunk()
          if vim.o.diff then
            feedkeys('[c', 'n')
          else
            gitsigns.prev_hunk()
          end
        end

        -- Next/previous hunk
        map('n', ']g', next_hunk, 'Next git hunk')
        map('n', '[g', prev_hunk, 'Previous git hunk')

        -- Text objects
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
        map({'o', 'x'}, 'ah', gitsigns.select_hunk)
      end,
    })

    -- Workaround for bug where change highlight switches for some reason
    vim.api.nvim_set_hl(0, 'GitGutterChange', { link = 'DiffChange' })
    vim.opt.diffopt:append { 'algorithm:patience' } -- Use patience diff algorithm
  end,
}
