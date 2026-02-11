--------------
-- Gitsigns --
--------------
return {
  'lewis6991/gitsigns.nvim',
  dependencies = 'tpope/vim-repeat',
  event = 'VeryLazy',
  config = function()
    local map = require('utils').map
    local gitsigns = require('gitsigns')

    local signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      changedelete = { text = '│' },
      delete       = { text = '▁' },
      topdelete    = { text = '▔' },
    }

    gitsigns.setup({
      signs = signs,
      signs_staged = signs,
      attach_to_untracked = false,
      trouble = false,
      worktrees = {
        -- .dotfiles/ is a bare git repo
        { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. '/.dotfiles' }
      },
      on_attach = function()
        local function git_blame()
          gitsigns.blame_line({
            full = true,
            ignore_whitespace = true,
          })
        end

        map('n', '<leader>gp', gitsigns.preview_hunk, 'Preview git hunk')
        map('n', 'gb',         git_blame,             'Git blame line')

        -- Text objects
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        map({ 'o', 'x' }, 'ah', gitsigns.select_hunk)
      end,
    })

    local function next_hunk()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end

    local function prev_hunk()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end

    local nx = { 'n', 'x' }

    map(nx,  '<leader>ghr', gitsigns.reset_hunk,   'Reset git hunk')
    map('n', '<leader>ghR', gitsigns.reset_buffer, 'Reset entire buffer')

    -- Next/previous hunk
    map(nx, ']g', next_hunk, 'Next git hunk')
    map(nx, '[g', prev_hunk, 'Previous git hunk')

    -- Workaround for bug where change highlight switches for some reason
    vim.api.nvim_set_hl(0, 'GitGutterChange', { link = 'DiffChange' })
    vim.opt.diffopt:append { 'algorithm:patience' } -- Use patience diff algorithm
  end,
}
