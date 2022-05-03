---------------
-- Nvim-tree --
---------------
return { 'kyazdani42/nvim-tree.lua',
  after = 'nvim-web-devicons',
  module_pattern = 'nvim-tree.*',
  keys = {'<leader>`', '<leader>`', '<leader>~', {'n', 'gf'}},
  cmd = {
    'NvimTreeOpen',
    'NvimTreeToggle',
    'NvimTreeFocus',
    'NvimTreeFindFile',
  },
  config = function()
    local map, autocmd = require('../utils').map, require('../utils').autocmd

    local callback = require('nvim-tree.config').nvim_tree_callback
    local nvim_tree = require('nvim-tree')

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
      renderer = {
        indent_markers = {
          enable = true,
        }
      },
      view = {
        width = 40,
        mappings = {
          list = {
            { key = 'l',     cb = callback('edit') },
            { key = 'h',     cb = callback('close_node') },
            { key = '>',     cb = callback('cd') },
            { key = '<',     cb = callback('dir_up') },
            { key = 'd',     cb = callback('trash') },
            { key = 'D',     cb = callback('remove') },
            { key = '<C-r>', cb = callback('refresh') },
            { key = 'R',     cb = callback('full_rename') },
            { key = '<Tab>', cb = callback('preview') },
            { key = '<C-s>', cb = callback('split') },
            { key = 'gh',    cb = callback('show_file_info') },
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
  end
}
