----------------
-- Telekasten --
----------------
local templates_path = vim.fn.stdpath('config') .. '/lua/configs/telekasten/templates'
local notes_path = vim.fn.expand('~/zettelkasten')

return {
  'renerocksai/telekasten.nvim',
  dependencies = 'nvim-telescope/telescope.nvim',
  ft = 'markdown',
  cmd = 'Telekasten',
  commit = '4a5e57eee9c5154ed77423bb7fa6619fdb0784cd',
  keys = {
    { '<leader>zn', ':Telekasten new_note<CR>',       desc = 'New note',                silent = true },
    { '<leader>zb', ':Telekasten show_backlinks<CR>', desc = 'Show backlinks',          silent = true },
    { '<leader>zz', ':Telekasten panel<CR>',          desc = 'Open Telekasten actions', silent = true },
    { '<leader>zf', ':Telekasten find_notes<CR>',     desc = 'Find notes',              silent = true },
    { '<leader>z/', ':Telekasten search_notes<CR>',   desc = 'Search in notes',         silent = true },
    { '<leader>zt', ':Telekasten show_tags<CR>',      desc = 'Find tags',               silent = true },
    { '<leader>zl', ':Telekasten insert_link<CR>',    desc = 'Insert link to note',     silent = true },
    { '<leader>zg', ':Telekasten follow_link<CR>',    desc = 'Follow link to note',     silent = true },
    { '<leader>zw', ':Telekasten goto_thisweek<CR>',  desc = 'Go to weekly note',       silent = true },
    { '<leader>zd', ':Telekasten goto_today<CR>',     desc = 'Go to today\'s note',     silent = true },
  },
  opts = {
    auto_set_filetype = false, -- Fixes https://github.com/renerocksai/telekasten.nvim/issues/279
    subdirs_in_links = true,
    command_palette_theme = 'get_dropdown',
    filename_space_subst = '-',
    home = notes_path,
    dailies = notes_path .. '/dailies',
    weeklies = notes_path .. '/weeklies',
    template_new_note = templates_path .. '/new-note.md',
    template_new_daily = templates_path .. '/new-daily.md',
    template_new_weekly = templates_path .. '/new-weekly.md',
  }
}
