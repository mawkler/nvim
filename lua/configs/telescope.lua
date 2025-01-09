---------------
-- Telescope --
---------------

local fd_ignore_file = vim.fn.expand('$HOME/') .. '.rgignore'
local cder_dir_cmd = {
  'fd',
  '-t',
  'd',
  '--hidden',
  '--ignore-file',
  fd_ignore_file,
  '.',
}

local function telescope_markdowns()
  require('telescope.builtin').find_files({
    search_dirs = { '$MARKDOWNS' },
    prompt_title = 'Markdowns',
    path_display = function(_, path)
      local relative_path, _ = path:gsub(vim.fn.expand('$MARKDOWNS'), '')
      return relative_path
    end,
  })
end

local function telescope_config()
  require('telescope.builtin').find_files({
    search_dirs = { '$HOME/.config/nvim/' },
    prompt_title = 'Neovim config',
    no_ignore = true,
    hidden = true,
    path_display = function(_, path)
      local relative_path, _ = path:gsub(vim.fn.expand('$HOME/.config/nvim/'), '')
      return relative_path
    end,
  })
end

local function grep_string()
  vim.g.grep_string_mode = true
  vim.ui.input({ prompt = 'Grep string', default = vim.fn.expand("<cword>") },
    function(value)
      if value ~= nil then
        require('telescope.builtin').grep_string({ search = value })
      end
      vim.g.grep_string_mode = false
    end)
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies =  {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'jvgrootveld/telescope-zoxide' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'Zane-/cder.nvim' },
    { 'rcarriga/nvim-notify' },
    { 'mfussenegger/nvim-dap' },
    { 'rafi/telescope-thesaurus.nvim' },
    { 'ThePrimeagen/git-worktree.nvim' },
  },
  cmd = 'Telescope',
  keys = {
    { '<C-p>',      '<cmd>Telescope find_files<CR>',                desc = 'Find files' },
    { '<leader>tt', '<cmd>Telescope<CR>',                           desc = 'Recently used files' },
    { '<leader>F',  '<cmd>Telescope live_grep<CR>',                 desc = 'Live grep' },
    { '<leader>B',  '<cmd>Telescope buffers<CR>',                   desc = 'Open buffers' },
    { '<leader>to', '<cmd>Telescope oldfiles<CR>',                  desc = 'Recently used files' },
    { '<leader>h',  '<cmd>Telescope help_tags<CR>',                 desc = 'Help tags' },
    { '<leader>tH', '<cmd>Telescope highlights<CR>',                desc = 'Highlights' },
    { '<leader>tc', '<cmd>Telescope commands<CR>',                  desc = 'Commands' },
    { '<leader>tm', '<cmd>Telescope keymaps<CR>',                   desc = 'Keymaps' },
    { '<leader>t/', '<cmd>Telescope search_history<CR>',            desc = 'Search history' },
    { '<leader>tD', '<cmd>Telescope diagnostics<CR>',               desc = 'Diagnostics' },
    { '<leader>t?', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy find in buffer' },
    { '<leader>tq', '<cmd>Telescope quickfix<CR>',                  desc = 'Quickfix' },
    { '<leader>tQ', '<cmd>Telescope quickfixhistory<CR>',           desc = 'Quickfix history' },
    { '<leader>tr', '<cmd>Telescope resume<CR>',                    desc = 'Resume latest telescope session' },
    { '<leader>tg', '<cmd>Telescope git_files<CR>',                 desc = 'Find git files' },
    { 'sp',         '<cmd>Telescope spell_suggest<CR>',             desc = 'Spell suggestions' },

    { '<leader>M',  telescope_markdowns, desc = 'Filter markdowns' },
    { '<leader>n',  telescope_config, desc = 'Filter Neovim config' },

    { '<leader>td', '<cmd>Telescope dap commands<CR>', desc = 'DAP commands' },
    { '<leader>tb', '<cmd>Telescope dap list_breakpoints<CR>', desc = 'DAP breakpoints'  },
    { '<leader>tv', '<cmd>Telescope dap variables<CR>', desc = 'DAP variables'  },
    { '<leader>tf', '<cmd>Telescope dap frames<CR>', desc = 'DAP variables'  },

    { '<leader>tT', '<cmd>Telescope thesaurus lookup<CR>',  desc = 'Thesaurus' },
    { '<leader>tn', '<cmd>Telescope notify notify<CR>',     desc = 'Notifications' },
    { '<leader>m',  '<cmd>Telescope frecency frecency<CR>', desc = 'Frecency' },

    { 'cd', function() require('telescope').extensions.cder.cder() end, desc = 'Change directory' },
    { 'cD', function()
      local append = require('utils').append
      return require('telescope').extensions.cder.cder({
        dir_command = append(cder_dir_cmd, vim.env.HOME),
        prompt_title = 'Change Directory',
      })
    end, desc = 'Change directory (from home directory)' },
    { '<M-z>', '<cmd>Telescope zoxide list<CR>' , desc = 'Change directory with zoxide'  },

    { mode = {'n', 'x'}, '<leader>/', grep_string, 'Grep string' },
  },
  config = function()
    local feedkeys = require('utils').feedkeys

    local telescope = require('telescope')
    local themes = require('telescope.themes')

    local cder_preview_cmed = 'exa '
      .. '--color=always '
      .. '-T '
      .. '--level=2 '
      .. '--icons '
      .. '--git-ignore '
      .. '--git '
      .. '--ignore-glob=.git'

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
          previewer_command = cder_preview_cmed,
          dir_command = cder_dir_cmd,
          mappings = {
            default = function(directory)
              vim.fn.system({ 'zoxide', 'add', directory })
              vim.cmd.cd(directory)
            end,
            ['<C-t>'] = function(directory)
              vim.fn.system({ 'zoxide', 'add', directory })
              vim.cmd.tcd(directory)
            end,
          },
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
    telescope.load_extension('notify')
    telescope.load_extension('cder')
    telescope.load_extension('git_worktree')

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
