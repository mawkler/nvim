----------------
-- Telekasten --
----------------
local templates_path = vim.fn.stdpath('config') .. '/lua/configs/telekasten/templates'

return {
  'renerocksai/telekasten.nvim',
  dependencies = 'nvim-telescope/telescope.nvim',
  ft = 'markdown',
  cmd = 'Telekasten',
  keys = {
    { '<leader>zn', ':Telekasten new_note<CR>',       desc = 'New Zettlekasten note',            silent = true },
    { '<leader>zb', ':Telekasten show_backlinks<CR>', desc = 'Show Zettlekasten backlinks',      silent = true },
    { '<leader>zz', ':Telekasten panel<CR>',          desc = 'Open Zettlekasten actions',        silent = true },
    { '<leader>zf', ':Telekasten find_notes<CR>',     desc = 'Find Zettlekasten notes',          silent = true },
    { '<leader>zt', ':Telekasten show_tags<CR>',      desc = 'Find Zettlekasten tags',           silent = true },
    { '<leader>zw', ':Telekasten goto_thisweek<CR>',  desc = 'Go to weekly Zettlekasten note',   silent = true },
    { '<leader>zd', ':Telekasten goto_today<CR>',     desc = 'Go to today\'s Zettlekasten note', silent = true },
  },
  opts = {
    home = vim.fn.expand('~/zettelkasten'),
    auto_set_filetype = false, -- Fixes https://github.com/renerocksai/telekasten.nvim/issues/279
    filename_space_subst = '-',
    template_new_note = templates_path .. '/new-note.md',
    template_new_daily = templates_path .. '/new-daily.md',
    template_new_weekly = templates_path .. '/new-weekly.md',
  }
}
