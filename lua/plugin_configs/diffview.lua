--------------
-- Diffview --
--------------
local map = require('../utils').map

local dv_callback = require('diffview.config').diffview_callback
require('diffview').setup {
  enhanced_diff_hl = false,
  file_panel = {
    width = 40
  },
  file_history_panel = {
    height = 15,
  },
  key_bindings = {
    view = {
      ['<C-j>'] = dv_callback('select_next_entry'),
      ['<C-k>'] = dv_callback('select_prev_entry'),
      ['<C-s>'] = dv_callback('goto_file_split'),
      ['<C-t>'] = dv_callback('goto_file_tab'),
      ['~']     = dv_callback('focus_files'),
      ['`']     = dv_callback('toggle_files'),
    },
    file_panel = {
      ['<Space>']  = dv_callback('select_entry'),
      ['<CR>']     = dv_callback('focus_entry'),
      ['gf']       = dv_callback('goto_file_edit'),
      ['<C-j>']    = dv_callback('select_next_entry'),
      ['<C-k>']    = dv_callback('select_prev_entry'),
      ['<C-t>']    = dv_callback('goto_file_tab'),
      ['<Esc>']    = dv_callback('toggle_files'),
      ['`']        = dv_callback('toggle_files'),
      ['<space>e'] = dv_callback(),
      ['<space>b'] = dv_callback()
    },
    file_history_panel = {
      ['!']        = dv_callback('options'),
      ['<CR>']     = dv_callback('open_in_diffview'),
      ['<Space>']  = dv_callback('select_entry'),
      ['<C-j>']    = dv_callback('select_next_entry'),
      ['<C-k>']    = dv_callback('select_prev_entry'),
      ['gf']       = dv_callback('goto_file'),
      ['<C-s>']    = dv_callback('goto_file_split'),
      ['<C-t>']    = dv_callback('goto_file_tab'),
      ['~']        = dv_callback('focus_files'),
      ['`']        = dv_callback('toggle_files'),
      ['<space>e'] = dv_callback(),
      ['<space>b'] = dv_callback()
    },
    option_panel = {
      ['<CR>'] = dv_callback('select')
    }
  }
}

map('n', '<leader>gD', '<cmd>DiffviewOpen<CR>')
map('n', '<leader>gH', '<cmd>DiffviewFileHistory<CR>')
