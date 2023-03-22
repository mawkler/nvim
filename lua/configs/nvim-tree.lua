---------------
-- Nvim-tree --
---------------
return {
  'kyazdani42/nvim-tree.lua',
  dependencies = 'kyazdani42/nvim-web-devicons',
  keys = {'<leader>`', '<leader>`', '<leader>~', 'gf'},
  cmd = {
    'NvimTreeOpen',
    'NvimTreeToggle',
    'NvimTreeFocus',
    'NvimTreeFindFile',
  },
  config = function()
    local nvim_tree, api = require('nvim-tree'), require('nvim-tree.api')
    local node, tree, fs, marks = api.node, api.tree, api.fs, api.marks

    nvim_tree.setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true
      },
      disable_netrw = false,
      update_cwd = true,
      git = {
        ignore = false,
      },
      filesystem_watchers = {
        enable = true,
      },
      renderer = {
        highlight_opened_files = 'all',
        special_files = {},
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            default = '' ,
            git = {
              unstaged  = '',
              staged    = '',
              deleted   = '',
              untracked = '◌',
              ignored   = '',
            }
          },
          show = {
            folder_arrow = false
          },
          git_placement = 'signcolumn',
        }
      },
      view = {
        width = 40,
      },
      on_attach = function(bufnr)
        local map = function(lhs, rhs, desc)
          require('utils').map('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Custom mappings
        map('l',     node.open.edit,             'Open')
        map('h',     node.navigate.parent_close, 'Close')
        map(']g',    node.navigate.git.next,     'Next git node')
        map('[g',    node.navigate.git.prev,     'Previous git node')
        map('<Tab>', node.open.preview,          'Preview')
        map('<C-s>', node.open.horizontal,       'Open in split')
        map('gh',    node.show_info_popup,       'File information')
        map('C',     tree.collapse_all,          'Close all')
        map('>',     tree.change_root_to_node,   'CD')
        map('<',     tree.change_root_to_parent, 'CD up')
        map('<C-r>', tree.reload,                'Refresh')
        map('<Esc>', tree.close,                 'Close')
        map('d',     fs.trash,                   'Trash')
        map('D',     fs.remove,                  'Delete')

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
      pattern = 'NvimTree_1',
      command = 'NvimTreeRefresh',
      group   = 'NvimTreeRefresh'
    })

    local function remove_highlight(group)
      vim.api.nvim_set_hl(0, group, { fg = nil, bg = nil })
    end

    remove_highlight('NvimTreeFileDirty')
    remove_highlight('NvimTreeFileStaged')
    remove_highlight('NvimTreeFileMerge')
    remove_highlight('NvimTreeFileRenamed')
    remove_highlight('NvimTreeFileNew')
    remove_highlight('NvimTreeFileDeleted')

    local map = require('utils').map
    map('n', '<leader>`', api.tree.toggle, 'Toggle file tree')
    map('n', '<leader>~', vim.cmd.NvimTreeFindFile, 'Show current file in file tree')

    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', {
      link = 'IndentBlanklineChar',
    })

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      pattern = 'NvimTree*',
      callback = function()
        local def = vim.api.nvim_get_hl_by_name('Cursor', true)
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, {
          blend = 100,
        }))
        vim.opt.guicursor:append('a:Cursor/lCursor')
      end,
    })

    vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed', 'WinLeave' }, {
      pattern = 'NvimTree*',
      callback = function()
        local def = vim.api.nvim_get_hl_by_name('Cursor', true)
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, {
          blend = 0,
        }))
        vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
      end,
    })
  end
}
