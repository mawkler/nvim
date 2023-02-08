---------------
-- Telescope --
---------------
return { 'nvim-telescope/telescope.nvim',
  dependencies =  {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'jvgrootveld/telescope-zoxide' },
    { 'dhruvmanila/telescope-bookmarks.nvim' },
    { 'nvim-telescope/telescope-cheat.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-frecency.nvim', dependencies = 'tami5/sqlite.lua' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'Zane-/cder.nvim' },
    { 'rcarriga/nvim-notify' },
    { 'mfussenegger/nvim-dap' },
  },
  config = function()
    local feedkeys = require('utils').feedkeys
    local map = require('utils').map
    local append = require('utils').append

    local fn, api = vim.fn, vim.api

    local telescope = require('telescope')
    local themes = require('telescope.themes')
    local extensions = telescope.extensions
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    local conf = require('telescope.config').values
    local action_state = require('telescope.actions.state')

    local fd_ignore_file = fn.expand('$HOME/') .. '.rgignore'
    local cder_dir_cmd = {
      'fd',
      '-t',
      'd',
      '--hidden',
      '--ignore-file',
      fd_ignore_file,
      '.',
    }

    -- Don't show line text, just the file name
    local horizontal_picker = { show_line = false }

    local dropdown_picker = themes.get_dropdown({
      show_line = false,
      layout_config = { mirror = true },
    })

    local cursor_picker = themes.get_cursor({ show_line = false })

    -- Mappings for opening multiple files from find_files, etc.
    local multi_open_mappings = require('configs.telescope-multiopen')

    -- Zoxide
    require('telescope._extensions.zoxide.config').setup({})

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-j>']  = 'move_selection_next',
            ['<C-k>']  = 'move_selection_previous',
            ['<C-p>']  = 'cycle_history_prev',
            ['<C-n>']  = 'cycle_history_next',
            ['<C-b>']  = 'preview_scrolling_up',
            ['<C-f>']  = 'preview_scrolling_down',
            ['<C-q>']  = 'close',
            ['<M-a>']  = 'toggle_all',
            ['<M-q>']  = 'smart_send_to_qflist',
            ['<M-Q>']  = 'smart_add_to_qflist',
            ['<M-l>']  = 'smart_send_to_loclist',
            ['<M-L>']  = 'smart_add_to_loclist',
            ['<M-y>']  = 'open_qflist',
            ['<C-s>'] =  'select_horizontal',
            ['<C-a>']  = function() feedkeys('<Home>') end,
            ['<C-e>']  = function() feedkeys('<End>') end,
            ['<M-BS>'] = function() vim.api.nvim_input('<C-w>') end,
            ['<C-u>']  = false,
          },
          n = {
            ['<C-q>'] = 'close',
            ['<C-c>'] = 'close',
            ['<C-s>'] =  'select_horizontal',
          }
        },
        layout_config = {
          width = 0.9,
          horizontal = {
            preview_width = 80
          }
        },
        dynamic_preview_title = true,
        selection_caret = '▶ ',
        multi_icon = '',
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        no_ignore = true,
        file_ignore_patterns = {
          '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
          '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/',
          '%.py[c]', '%.sw.?', '~$', '%.tags', '%.gemtags', '%.tmp',
          '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
          '%.class$', '%.pdb$', '%.dll$'
        }
      },
      pickers = {
        find_files                = { mappings = multi_open_mappings },
        oldfiles                  = { mappings = multi_open_mappings },
        current_buffer_fuzzy_find = { sorting_strategy = 'ascending' },
        quickfix                  = horizontal_picker,
        tagstack                  = horizontal_picker,
        jumplist                  = horizontal_picker,
        lsp_references            = horizontal_picker,
        lsp_definitions           = dropdown_picker,
        lsp_type_definitions      = dropdown_picker,
        lsp_implementations       = dropdown_picker,
        buffers                   = dropdown_picker,
        spell_suggest             = cursor_picker,
      },
      extensions = {
        bookmarks = {
          selected_browser = 'brave',
          url_open_command = 'xdg-open &>/dev/null',
        },
        sessions_picker = {
          sessions_dir = vim.fn.stdpath('data') ..'/sessions/'
        },
        cder = {
          previewer_command = 'exa '
            .. '--color=always '
            .. '-T '
            .. '--level=2 '
            .. '--icons '
            .. '--git-ignore '
            .. '--git '
            .. '--ignore-glob=.git',
          dir_command = cder_dir_cmd,
        },
        zoxide = {
          prompt_title = 'Zoxide',
          verbose = false,
        }
      }
    }

    telescope.load_extension('zoxide')
    telescope.load_extension('fzf')
    telescope.load_extension('bookmarks')
    telescope.load_extension('frecency')
    telescope.load_extension('cheat')
    telescope.load_extension('notify')
    telescope.load_extension('cder')
    telescope.load_extension('git_worktree')

    function _G.telescope_markdowns()
      builtin.find_files({
        search_dirs = { '$MARKDOWNS' },
        prompt_title = 'Markdowns',
        path_display = function(_, path)
          return path:gsub(vim.fn.expand('$MARKDOWNS'), '')
        end,
      })
    end

    function _G.telescope_config()
      builtin.find_files({
        search_dirs = { '$HOME/.config/nvim/' },
        prompt_title = 'Neovim config',
        no_ignore = true,
        hidden = true,
        path_display = function(_, path)
          -- TODO: refactor this truncation function call
          return path:gsub(vim.fn.expand('$HOME/.config/nvim/'), '')
        end,
      })
    end

    function _G.telescope_cd(dir)
      if dir == nil then dir = '.' end
      local opts = {cwd = dir}
      local ignore_file = fn.expand('$HOME/') .. '.rgignore'

      pickers.new(opts, {
        prompt_title = 'Change Directory',
        finder = finders.new_oneshot_job(
          { 'fd', '-t', 'd', '--hidden', '--ignore-file', ignore_file },
          opts
        ),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, attach_map)
          -- These two mappings fix issue with custom actions
          attach_map('n', '<CR>', 'select_default')
          attach_map('i', '<CR>', 'select_default')
          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            if selection ~= nil then
              actions.close(prompt_bufnr)
              -- TODO: allow using tcd on <C-t>
              api.nvim_command('cd ' .. dir .. '/' .. selection[1])
            end
          end)
          return true
        end,
      }):find()
    end

    local function grep_string()
      vim.g.grep_string_mode = true
      vim.ui.input({ prompt = 'Grep string', default = fn.expand("<cword>") },
        function(value)
          if value ~= nil then
            require('telescope.builtin').grep_string({ search = value })
          end
          vim.g.grep_string_mode = false
        end)
    end

    -- TODO: lazy load mappings with lazy.nvim
    map('n', '<C-p>', function()
      return builtin.find_files({ hidden = true })
    end, 'Find files')
    map({'n', 'x'}, '<leader>/', grep_string, 'Grep string')

    map('n', '<leader>F',  builtin.live_grep, 'Live grep')
    map('n', '<leader>B',  builtin.buffers, 'Open buffers')
    map('n', '<leader>m',  builtin.oldfiles, 'Recently used files')
    map('n', '<leader>th', extensions.frecency.frecency, 'Frecency')
    map('n', '<leader>h',  builtin.help_tags, 'Help tags')
    map('n', '<leader>tt', builtin.builtin, 'Builtin telescope commands')
    map('n', '<leader>tH', builtin.highlights, 'Highlights')
    map('n', '<leader>tc', builtin.commands, 'Commands')
    map('n', '<leader>tm', builtin.keymaps, 'Keymaps')
    map('n', '<leader>t/', builtin.search_history, 'Search history')
    map('n', '<leader>tD', builtin.diagnostics, 'Diagnostics')
    map('n', '<leader>t?', builtin.current_buffer_fuzzy_find, 'Fuzzy find in buffer')
    map('n', '<leader>tq', builtin.quickfix, 'Quickfix')
    map('n', '<leader>tQ', builtin.quickfixhistory, 'Quickfix history')
    map('n', '<leader>tr', builtin.resume, 'Resume latest telescope session')
    map('n', '<leader>tg', builtin.git_files, 'Find git files')
    map('n', 'sp',         builtin.spell_suggest, 'Spell suggestions')

    map('n', 'cd',         extensions.cder.cder, 'Change directory')
    map('n', 'cD',         function()
      return extensions.cder.cder({
        dir_command = append(cder_dir_cmd, vim.env.HOME),
        prompt_title = 'Change Directory',
      })
    end, 'Change directory (from home directory)')
    map('n', '<M-z>',      extensions.zoxide.list, 'Change directory with zoxide')
    map('n', '<leader>tB', extensions.bookmarks.bookmarks, 'Bookmarks')
    map('n', '<leader>tC', function() return extensions.cheat.fd({}) end, 'Cheat.sh')
    map('n', '<leader>M',  telescope_markdowns, 'Markdowns')
    map('n', '<leader>n',  telescope_config, 'Neovim config')
    map('n', '<leader>tn', extensions.notify.notify, 'Notifications')

    map('n', '<leader>td', extensions.dap.commands)
    map('n', '<leader>tb', extensions.dap.list_breakpoints)
    map('n', '<leader>tv', extensions.dap.variables)
    map('n', '<leader>tf', extensions.dap.frames)
  end
}
