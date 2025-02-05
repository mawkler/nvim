---------------
-- Nvim-tree --
---------------

local function find_file()
  local opts = { open = true, focus = true, update_root = true }
  require('nvim-tree.api').tree.find_file(opts)
end

return {
  'kyazdani42/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = vim.fn.argc() == 0,
  keys = {
    { '<leader>`', function() require('nvim-tree.api').tree.toggle() end, mode = 'n', desc = 'Toggle file tree' },
    { '<leader>~', find_file,                                             mode = 'n', desc = 'Show current file in file tree', },
  },
  config = function()
    local nvim_tree, api = require('nvim-tree'), require('nvim-tree.api')
    local node, tree, fs, marks = api.node, api.tree, api.fs, api.marks
    local git_navigate = node.navigate.git

    nvim_tree.setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true
      },
      disable_netrw = false,
      update_cwd = true,
      filesystem_watchers = {
        enable = true,
      },
      renderer = {
        highlight_opened_files = 'all',
        special_files = {},
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            default = '',
            git = {
              unstaged  = '',
              staged    = '',
              deleted   = '',
              untracked = '◌',
              ignored   = '',
            }
          },
          web_devicons = {
            folder = {
              enable = true, -- Special folder devicon icons
              color = false,
            },
          },
          show = {
            folder_arrow = false
          },
          git_placement = 'signcolumn',
        },
        highlight_git = 'name',
      },
      view = {
        width = 40,
      },
      on_attach = function(bufnr)
        local map = function(lhs, rhs, desc)
          require('utils').map('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Custom mappings
        map('l',     node.open.edit,                    'Open')
        map('h',     node.navigate.parent_close,        'Close')
        map(']g',    git_navigate.next_skip_gitignored, 'Next git node')
        map('[g',    git_navigate.prev_skip_gitignored, 'Previous git node')
        map('<Tab>', node.open.preview,                 'Preview')
        map('<C-s>', node.open.horizontal,              'Open in split')
        map('gh',    node.show_info_popup,              'File information')
        map('C',     tree.collapse_all,                 'Close all')
        map('>',     tree.change_root_to_node,          'CD')
        map('<',     tree.change_root_to_parent,        'CD up')
        map('<C-r>', tree.reload,                       'Refresh')
        map('<Esc>', tree.close,                        'Close')
        map('d',     fs.trash,                          'Trash')
        map('D',     fs.remove,                         'Delete')

        -- Recommended defaults
        map('<C-t>', node.open.tab,                  'Open: New Tab')
        map('<C-v>', node.open.vertical,             'Open: Vertical Split')
        map('.',     node.run.cmd,                   'Run Command')
        map(']e',    node.navigate.diagnostics.next, 'Next Diagnostic')
        map('[e',    node.navigate.diagnostics.prev, 'Prev Diagnostic')
        map('J',     node.navigate.sibling.last,     'Last Sibling')
        map('K',     node.navigate.sibling.first,    'First Sibling')
        map('P',     node.navigate.parent,           'Parent Directory')
        map('s',     node.run.system,                'Run System')
        map('B',     tree.toggle_no_buffer_filter,   'Toggle No Buffer')
        map('C',     tree.toggle_git_clean_filter,   'Toggle Git Clean')
        map('H',     tree.toggle_hidden_filter,      'Toggle Dotfiles')
        map('I',     tree.toggle_gitignore_filter,   'Toggle Git Ignore')
        map('S',     tree.search_node,               'Search')
        map('U',     tree.toggle_custom_filter,      'Toggle Hidden')
        map('g?',    tree.toggle_help,               'Help')
        map('W',     tree.collapse_all,              'Collapse')
        map('F',     api.live_filter.clear,          'Clean Filter')
        map('f',     api.live_filter.start,          'Filter')
        map('m',     marks.toggle,                   'Toggle Bookmark')
        map('bmv',   marks.bulk.move,                'Move Bookmarked')
        map('a',     fs.create,                      'Create')
        map('c',     fs.copy.node,                   'Copy')
        map('gy',    fs.copy.absolute_path,          'Copy Absolute Path')
        map('p',     fs.paste,                       'Paste')
        map('r',     fs.rename,                      'Rename')
        map('x',     fs.cut,                         'Cut')
        map('y',     fs.copy.filename,               'Copy Name')
        map('Y',     fs.copy.relative_path,          'Copy Relative Path')

        map('<2-LeftMouse>',  api.node.open.edit,       'Open')
        map('<2-RightMouse>', tree.change_root_to_node, 'CD')
      end,
    })

    vim.api.nvim_create_augroup('NvimTreeRefresh', {})
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern  = 'NvimTree_1',
      group    = 'NvimTreeRefresh',
      callback = api.tree.reload,
    })

    local function remove_highlight(group)
      vim.api.nvim_set_hl(0, group, { fg = nil, bg = nil })
    end

    -- Remove all name highlights except ignores
    -- `renderer.highlight_git = 'name'` sets these colors
    remove_highlight('NvimTreeDiagnosticHintFolderHL')
    remove_highlight('NvimTreeDiagnosticHintFileHL')
    remove_highlight('NvimTreeGitFolderRenamedHL')
    remove_highlight('NvimTreeGitFolderDeletedHL')
    remove_highlight('NvimTreeGitFolderStagedHL')
    remove_highlight('NvimTreeGitFolderMergeHL')
    remove_highlight('NvimTreeGitFolderDirtyHL')
    remove_highlight('NvimTreeGitFileRenamedHL')
    remove_highlight('NvimTreeGitFileDeletedHL')
    remove_highlight('NvimTreeGitFileStagedHL')
    remove_highlight('NvimTreeGitFolderNewHL')
    remove_highlight('NvimTreeGitFileMergeHL')
    remove_highlight('NvimTreeGitFileDirtyHL')
    remove_highlight('NvimTreeGitFileNewHL')

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      pattern = 'NvimTree*',
      callback = function()
        local hi = vim.api.nvim_get_hl(0, { name = 'Cursor' })
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', hi, {
          blend = 100,
        }))
        vim.opt.guicursor:append('a:Cursor/lCursor')
      end,
    })

    vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed', 'WinLeave' }, {
      pattern = 'NvimTree*',
      callback = function()
        local hi = vim.api.nvim_get_hl(0, { name = 'Cursor' })
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', hi, {
          blend = 0,
        }))
        vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
      end,
    })
  end
}
