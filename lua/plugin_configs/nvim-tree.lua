---------------
-- Nvim-tree --
---------------

local map = require('../utils').map
local autocmd = require('../utils').autocmd

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_highlight_opened_files = 2
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_icons = {
  default = '' ,
  git = {
    ignored   = '',
    untracked = '',
    unstaged  = '',
    staged    = '',
    unmerged  = '',
    renamed   = '',
    deleted   = '',
  }
}

local tree_cb = require('nvim-tree.config').nvim_tree_callback
local nvim_tree = require('nvim-tree')

nvim_tree.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  disable_netrw = false,
  update_cwd = true,
  git = {
    ignore = false,
  },
  show_icons = {
    git = true,
    folders = true,
    files = true,
  },
  view = {
    width = 40,
    mappings = {
      list = {
      { key = 'l',       cb = tree_cb('edit') },
      { key = 'h',       cb = tree_cb('close_node') },
      { key = '>',       cb = tree_cb('cd') },
      { key = '<',       cb = tree_cb('dir_up') },
      { key = 'd',       cb = tree_cb('trash') },
      { key = 'D',       cb = tree_cb('remove') },
      { key = '<C-r>',   cb = tree_cb('refresh') },
      { key = 'R',       cb = tree_cb('full_rename') },
      { key = '<Space>', cb = tree_cb('preview') },
      { key = '<C-s>',   cb = tree_cb('split') },
      { key = 'gh',      cb = tree_cb('show_file_info') },
      }
    }
  }
}

autocmd('BufEnter', {
  pattern = 'NvimTree_1',
  command = 'NvimTreeRefresh',
  group   = 'NvimTreeRefresh'
})

map('n', '<leader>`', nvim_tree.toggle, 'Toggle file tree')
map('n', '<leader>~', function() return nvim_tree.find_file(true) end, 'Show current file in file tree')

vim.cmd 'hi! link NvimTreeIndentMarker IndentBlanklineChar'
