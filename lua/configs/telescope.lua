---------------
-- Telescope --
---------------
return { 'nvim-telescope/telescope.nvim',
  module_pattern = 'telescope%..*',
  requires =  {
    {'nvim-lua/popup.nvim', module_pattern = 'popup%..*'},
    {'nvim-lua/plenary.nvim'}
  },
  config = function()
    local feedkeys = require('../utils').feedkeys
    local map = require('../utils').map
    local fn, api = vim.fn, vim.api

    local telescope = require('telescope')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values

    -- Allows editing multiple files with multi selection
    -- Workaround for https://github.com/nvim-telescope/telescope.nvim/issues/1048
    local multiopen = function(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = #picker:get_multi_selection()
      if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
      end
      actions.send_selected_to_qflist(prompt_bufnr)

      local results = vim.fn.getqflist()

      for _, result in ipairs(results) do
        local current_file = vim.fn.bufname()
        local next_file = vim.fn.bufname(result.bufnr)

        if current_file == '' then
          vim.api.nvim_command('edit' .. ' ' .. next_file)
        else
          vim.api.nvim_command(open_cmd .. ' ' .. next_file)
        end
      end

      vim.api.nvim_command('cd .')
    end

    local function multi_selection_open(prompt_bufnr)
      multiopen(prompt_bufnr, 'edit')
    end

    local function multi_selection_open_vsplit(prompt_bufnr)
      multiopen(prompt_bufnr, 'vsplit')
    end

    local function multi_selection_open_split(prompt_bufnr)
      multiopen(prompt_bufnr, 'split')
    end

    local function multi_selection_open_tab(prompt_bufnr)
      multiopen(prompt_bufnr, 'tabedit')
    end

    local telescope_multiselect_mappings = {
      i = {
        ['<CR>'] = multi_selection_open,
        ['<C-v>'] = multi_selection_open_vsplit,
        ['<C-s>'] = multi_selection_open_split,
        ['<C-t>'] = multi_selection_open_tab,
      }
    }

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-p>'] = 'cycle_history_prev',
            ['<C-n>'] = 'cycle_history_next',
            ['<C-b>'] = 'preview_scrolling_up',
            ['<C-f>'] = 'preview_scrolling_down',
            ['<C-q>'] = 'close',
            ['<M-a>'] = 'toggle_all',
            ['<M-q>'] = 'smart_send_to_qflist',
            ['<M-Q>'] = 'smart_add_to_qflist',
            ['<M-l>'] = 'smart_send_to_loclist',
            ['<M-L>'] = 'smart_add_to_loclist',
            ['<M-y>'] = 'open_qflist',
            ['<C-a>'] = function() feedkeys('<Home>') end,
            ['<C-e>'] = function() feedkeys('<End>') end,
            ['<C-u>'] = false
          },
          n = {
            ['<C-q>'] = 'close',
            ['<C-c>'] = 'close',
          }
        },
        layout_config = {
          width = 0.9,
          horizontal = {
            preview_width = 80
          }
        },
        selection_caret = '▶ ',
        multi_icon = '',
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        no_ignore = true,
        file_ignore_patterns = {
          '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
          '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/', '%.py[c]',
          '%.sw.?', '~$', '%.tags', '%.gemtags', '%.csv$', '%.tsv$', '%.tmp',
          '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
          '%.class$', '%.pdb$', '%.dll$', '%.dat$'
        }
      },
      pickers = {
        find_files = { mappings = telescope_multiselect_mappings },
        grep_string = { mappings = telescope_multiselect_mappings }
      },
      extensions = {
        bookmarks = {
          selected_browser = 'brave',
          url_open_command = 'xdg-open &>/dev/null',
        },
        sessions_picker = {
          sessions_dir = vim.fn.stdpath('data') ..'/sessions/'
        }
      }
    }

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
      local ignore_file = fn.expand('$HOME/') .. '.agignore'

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
      -- print(vim.g.grep_string_mode)
      vim.ui.input({ prompt = 'Grep string', default = fn.expand("<cword>") },
        function(value)
          if value ~= nil then
            require('telescope.builtin').grep_string({ search = value })
          end
          vim.g.grep_string_mode = false
        end)
    end

    map('n', '<C-p>',      function() return builtin.find_files({hidden = true}) end, 'Find files')
    map('n', '<leader>f',  grep_string, 'Grep string')
    map('n', '<leader>/',  grep_string, 'Grep string')
    map('n', '<leader>F',  builtin.live_grep, 'Live grep')
    map('n', '<leader>B',  builtin.buffers, 'Open buffers')
    map('n', '<leader>m',  builtin.oldfiles, 'Recently used files')
    map('n', '<leader>th', telescope.extensions.frecency.frecency, 'Frecency')
    map('n', '<leader>h',  builtin.help_tags, 'Help tags')
    map('n', '<leader>tt', builtin.builtin, 'Builtin telescope commands')
    map('n', '<leader>tH', builtin.highlights, 'Highlights')
    map('n', '<leader>tm', builtin.keymaps, 'Keymaps')
    map('n', '<leader>ts', builtin.lsp_document_symbols, 'LSP document symbols')
    map('n', '<leader>tS', builtin.lsp_workspace_symbols, 'LSP workspace symbols')
    map('n', '<leader>tw', builtin.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
    map('n', '<leader>tr', builtin.resume, 'Resume latest telescope session')
    map('n', '<leader>tg', builtin.git_files, 'Find git files')

    map('n', 'cd',         telescope_cd, 'Change directory')
    map('n', 'cD',         function() return telescope_cd('~') end, 'cd from home directory')
    map('n', '<M-z>',      telescope.extensions.zoxide.list, 'Change directory with zoxide')
    map('n', '<leader>tb', telescope.extensions.bookmarks.bookmarks, 'Bookmarks')
    map('n', '<leader>s',  telescope.extensions.sessions_picker.sessions_picker, 'Sessions')
    map('n', '<leader>tc', function() return telescope.extensions.cheat.fd({}) end, 'Cheat.sh')
    map('n', '<leader>M',  telescope_markdowns, 'Markdowns')
    map('n', '<leader>n',  telescope_config, 'Neovim config')
    map('n', '<leader>tn', telescope.extensions.notify.notify, 'Notifications')

    telescope.load_extension('zoxide')
    telescope.load_extension('fzf')
    telescope.load_extension('bookmarks')
    telescope.load_extension('frecency')
    telescope.load_extension('cheat')
    telescope.load_extension('notify')
    telescope.load_extension('sessions_picker')
  end
}
