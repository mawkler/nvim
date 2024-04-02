---------------
-- Telescope --
---------------
return {
  'nvim-telescope/telescope.nvim',
  dependencies =  {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'jvgrootveld/telescope-zoxide' },
    { 'nvim-telescope/telescope-cheat.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'Zane-/cder.nvim' },
    { 'rcarriga/nvim-notify' },
    { 'mfussenegger/nvim-dap' },
  },
  event = 'VeryLazy',
  config = function()
    local feedkeys = require('utils').feedkeys
    local map = require('utils').map
    local append = require('utils').append

    local fn = vim.fn

    local telescope = require('telescope')
    local themes = require('telescope.themes')
    local extensions = telescope.extensions
    local builtin = require('telescope.builtin')

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
            ['<C-s>']  = 'select_horizontal',
            ['<C-CR>'] = 'to_fuzzy_refine',
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
          height = 0.6,
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
        },
        frecency = {
          db_safe_mode = false, -- Never ask for confirmation clean up DB
        },
      }
    }

    telescope.load_extension('zoxide')
    telescope.load_extension('fzf')
    telescope.load_extension('frecency')
    telescope.load_extension('cheat')
    telescope.load_extension('notify')
    telescope.load_extension('cder')
    telescope.load_extension('git_worktree')

    local function telescope_markdowns()
      builtin.find_files({
        search_dirs = { '$MARKDOWNS' },
        prompt_title = 'Markdowns',
        path_display = function(_, path)
          return path:gsub(vim.fn.expand('$MARKDOWNS'), '')
        end,
      })
    end

    local function telescope_config()
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
    map('n', '<leader>to', builtin.oldfiles, 'Recently used files')
    map('n', '<leader>m',  extensions.frecency.frecency, 'Frecency')
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
    map('n', '<leader>tC', function() return extensions.cheat.fd({}) end, 'Cheat.sh')
    map('n', '<leader>M',  telescope_markdowns, 'Markdowns')
    map('n', '<leader>n',  telescope_config, 'Neovim config')
    map('n', '<leader>tn', extensions.notify.notify, 'Notifications')

    map('n', '<leader>td', extensions.dap.commands)
    map('n', '<leader>tb', extensions.dap.list_breakpoints)
    map('n', '<leader>tv', extensions.dap.variables)
    map('n', '<leader>tf', extensions.dap.frames)

    -- Temporary workaround for https://github.com/nvim-telescope/telescope.nvim/issues/2766
    vim.api.nvim_create_autocmd('WinLeave', {
      callback = function()
        if vim.bo.ft == 'TelescopePrompt' and vim.fn.mode() == 'i' then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'i', false)
        end
      end,
    })
  end
}
