local cmd, fn, call = vim.cmd, vim.fn, vim.call
local opt, g, b, bo = vim.o, vim.g, vim.b, vim.bo
local api, lsp = vim.api, vim.lsp

-- Should be loaded before any other plugin
-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient')

require('packer').init {
  opt_default = false, -- Set to make loading plugins optional by default
  display = {
    keybindings = {
      quit = '<Esc>',
    }
  }
}

-- Returns the `require` for use in `config` parameter of packer's `use`
function GetConfig(module)
  return string.format('require("plugin_configs/%s")', module)
end

require('packer').startup(function()
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-fugitive',        -- :Git commands
    requires = 'tpope/vim-dispatch', -- Makes actions like `:Gpush` asynchronous
    cmd = {'G', 'Git', 'Gvdiffsplit'},
  }
  use { 'tpope/vim-eunuch' }
  use { 'tpope/vim-abolish', cmd = {'Abolish', 'S'} }
  use { 'inkarkat/vim-visualrepeat', requires = 'inkarkat/vim-ingo-library' }
  use { 'milkypostman/vim-togglelist', fn = 'ToggleQuickfixList' } -- Mapping to toggle QuickFix window
  use { 'kana/vim-niceblock', event = 'ModeChanged *:[vV]' } -- Improves visual mode
  use { 'kana/vim-textobj-syntax' }
  use { 'haya14busa/vim-textobj-function-syntax' }
  use { 'PeterRincker/vim-argumentative' }      -- Adds mappings for swapping arguments
  use { 'AndrewRadev/splitjoin.vim', keys = 'gS' }
  use { 'junegunn/vim-easy-align', keys = '<Plug>(EasyAlign)' }
  use { 'dkarter/bullets.vim', ft = 'markdown' } -- Autocomplete markdown lists, etc.
  use { 'Julian/vim-textobj-variable-segment', keys = {{'o', 'iv'}, {'o', 'av'}} } -- camelCase and snake_case text objects
  use { 'wsdjeg/vim-fetch' }                    -- Line and column position when opening file
  use { 'meain/vim-printer', keys = 'gp' }
  use { 'camspiers/lens.vim' }                  -- Automatic window resizing
  use { 'Ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryLookupCurrentWord' }
  use { 'mbbill/undotree',
    keys = '<leader>u',
    cmd = {'UndoTreeShow', 'UndoTreeToggle'},
    config = GetConfig('undotree'),
  }
  use { 'breuckelen/vim-resize',                -- Resizing with arrow keys
    cmd = {'CmdResizeUp', 'CmdResizeRight', 'CmdResizeDown', 'CmdResizeLeft'},
  }
  use { 'junegunn/vim-peekaboo' }               -- Register selection window
  use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
  use { 'RRethy/vim-hexokinase', run = 'make' } -- Displays the colours (rgb, etc.) in files
  use { 'mhinz/vim-startify',                   -- Nicer start screen
    requires = 'kyazdani42/nvim-web-devicons',
    config = GetConfig('startify'),
  }
  use { 'DanilaMihailov/beacon.nvim', event = 'WinEnter' } -- Flash the cursor location on jump
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'coreyja/fzf.devicon.vim',
    requires = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  }
  use { 'Xuyuanp/scrollbar.nvim', event = 'WinScrolled' }
  use { 'kyazdani42/nvim-web-devicons', config = GetConfig('web-devicons') }
  use { 'kyazdani42/nvim-tree.lua',             -- File explorer
    after = 'nvim-web-devicons',
    -- module_pattern = 'nvim-tree.*',
    config = GetConfig('nvim-tree')
  }
  use { 'romgrk/barbar.nvim' }                  -- Sexiest buffer tabline
  use { 'mhartington/formatter.nvim',           -- Auto formatting on save
    module = 'formatter',
    config = GetConfig('formatter'),
    event = 'BufWritePost',
    cmd = { 'Format', 'FormatWrite' },
  }
  use { 'karb94/neoscroll.nvim', event = 'WinScrolled', config = function()
    local scroll_speed = 140                    -- Smooth scrolling animations
    require('neoscroll').setup { easing_function = 'cubic' }
    require('neoscroll.config').set_mappings {
      ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', scroll_speed}},
      ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', scroll_speed}},
      ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
      ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', scroll_speed}},
      ['zt']    = {'zt', {scroll_speed}, 'sine'},
      ['zz']    = {'zz', {scroll_speed}, 'sine'},
      ['zb']    = {'zb', {scroll_speed}, 'sine'},
    }
  end }
  use { 'famiu/feline.nvim',                    -- Statusline creation framework
    requires = { 'SmiteshP/nvim-gps', 'nvim-lua/lsp-status.nvim' },
    after = 'onedark.nvim',
    config = function()
      local colors = require('onedark.colors').setup()
      require('statusline').setup({
        theme = colors,
        modifications = {
          bg = colors.bg_sidebar,
          fg = '#c8ccd4',
          line_bg = '#353b45',
          darkgray = '#9ba1b0',
          green = colors.green0,
          blue = colors.blue0,
          orange = colors.orange0,
          purple = colors.purple0,
          red = colors.red0,
          cyan = colors.cyan0,
        }
      })
      vim.opt.laststatus = 3 -- Global statusline
    end
  }
  use { 'j-hui/fidget.nvim', config = function()
    print('fidget')
    require('fidget').setup {                   -- LSP progress in the bottom right corner
      text = { spinner = 'dots', done = '' }
    }
  end }
  use { 'lewis6991/gitsigns.nvim' }             -- Git status in sign column
  use { 'neovim/nvim-lspconfig',                -- Enables built-in LSP
    requires = 'williamboman/nvim-lsp-installer',-- Adds LspInstall command
    config = GetConfig('lsp')
  }
  use { 'L3MON4D3/LuaSnip',                     -- Snippet engine
    -- module = 'luasnip',
    config = GetConfig('luasnip')
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'tzachar/cmp-tabnine', run = './install.sh' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'onsails/lspkind-nvim' }                -- VSCode-like completion icons
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  use { 'melkster/friendly-snippets' }          -- Snippet collection
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  }
  use { 'folke/trouble.nvim',
    cmd = 'TroubleToggle',
    keys = '<leader>E',
    config = GetConfig('trouble'),
  }
  use { 'b0o/schemastore.nvim'--[[ , ft = {'json', 'yaml'}  ]]}
  use { 'jvgrootveld/telescope-zoxide' }
  use { 'dhruvmanila/telescope-bookmarks.nvim' }
  use { 'nvim-telescope/telescope-cheat.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sqlite.lua' }
  use { 'JoseConseco/telescope_sessions_picker.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim',
    requires =  {
    {'nvim-lua/popup.nvim', module_pattern = 'popup%..*'},
    {'nvim-lua/plenary.nvim'}
    },
  }
  use { 'stevearc/dressing.nvim' }              -- Improves default `vim.ui` interfaces
  use { 'MunifTanjim/nui.nvim', module_pattern = 'nui.*' }                -- UI component library
  use { 'milisims/nvim-luaref' }                -- Vim :help reference for lua
  use { 'folke/lua-dev.nvim' }                  -- Lua signature help, docs and completion
  use { 'ethanholz/nvim-lastplace', config = function()
    require('nvim-lastplace').setup()           -- Reopen files at last edit position
  end }
  use { 'monaqa/dial.nvim',                     -- Enhanced increment/decrement
    -- module_pattern = 'dial%.command.*',
    config = GetConfig('dial')
  }
  use { 'numToStr/Comment.nvim', branch = 'plug' } -- TODO: remove `branch` once merged
  use { 'NTBBloodbath/rest.nvim'--[[ , cmd = 'Http'  ]]}-- For sending HTTP requests
  use { 'mfussenegger/nvim-dap',                -- Debugger client
    requires = 'rcarriga/nvim-dap-ui',          -- UI for nvim-dap
    config = GetConfig('dap'),
  }
  use { 'Pocco81/DAPInstall.nvim'--[[ , module_pattern = 'dap-install.*'   ]]} -- Managing debuggers
  use { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  use { 'ful1e5/onedark.nvim', config = GetConfig('onedark') }
  use { 'ThePrimeagen/refactoring.nvim' }
  use { 'Darazaki/indent-o-matic' }             -- Automatic indentation detection
  use { 'lewis6991/impatient.nvim' }            -- Improve startup time for Neovim
  use { 'bfredl/nvim-miniyank' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat', fn = 'repeat#set' }
  use { 'unblevable/quick-scope'--[[ , keys = { -- Highlight unique characters on t/f/T/F
    '<Plug>(QuickScopet)',
    '<Plug>(QuickScopef)',
    '<Plug>(QuickScopeT)',
    '<Plug>(QuickScopeF)',
  }  ]]}
  use { 'andymass/vim-matchup', keys = '%' }    -- Ads additional `%` commands
  use { 'windwp/nvim-autopairs',                -- Auto-close brackets, etc.
    event = 'ModeChanged *:[iI]' ,
    config = GetConfig('autopairs')
  }
  use { 'junegunn/fzf.vim', cmd = {'Ag', 'Rg'} }
  use { 'vim-scripts/capslock.vim' }            -- Adds caps lock mapping to insert mode
  use { 'vim-scripts/StripWhiteSpaces', event = 'BufWrite' }
  use { 'inkarkat/vim-ConflictMotions',
    requires = {'inkarkat/vim-ingo-library', 'inkarkat/vim-CountJump'},
  }
  use { 'kana/vim-textobj-user' }
  use { 'kana/vim-textobj-function' }
  use { 'kana/vim-textobj-line' }
  use { 'kana/vim-textobj-entire' }
  use { 'lervag/vimtex', ft = {'tex', 'latex'} }
  use { 'AndrewRadev/dsf.vim' }
  use { 'michaeljsmith/vim-indent-object' }
  use { 'wellle/targets.vim' }                  -- Adds arguments, etc. as text objects
  use { 'romainl/vim-cool' }                    -- Better search highlighting behaviour
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
  use { 'coachshea/vim-textobj-markdown', ft = 'markdown' }
  use { 'tommcdo/vim-exchange' }                -- Swapping two text objects
  use { 'itchyny/vim-highlighturl' }            -- Highlights URLs everywhere
  use { 'AndrewRadev/bufferize.vim', cmd = 'Bufferize' } -- Send command output to temporary buffer
  use { 'xolox/vim-session',
    requires = {'xolox/vim-misc'},
    config = function()
      vim.g.session_autosave = 'yes'
      vim.g.session_autosave_periodic = 1
      vim.g.session_autosave_silent = 1
      vim.g.session_default_overwrite = 1
      vim.g.session_autoload = 'no'
      vim.g.session_lock_enabled = 0
      vim.g.session_directory = vim.g.startify_session_dir
    end
  }
  use { 'rhysd/vim-grammarous' }                -- LanguageTool grammar checking
  use { 'github/copilot.vim', event = 'ModeChanged *:[iI]'  } -- GitHub Copilot
  use { 'tvaintrob/bicep.vim', ft = 'bicep' }
  use { 'luukvbaal/stabilize.nvim', event = 'WinNew', config = function()
    return require('stabilize').setup()
  end }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'ggandor/lightspeed.nvim' }             -- Moving cursor anywhere in any window
  use { 'sindrets/winshift.nvim', module = 'winshift', config = function()
    require('winshift').setup {                 -- Improved window movement
      window_picker_ignore = {
        filetype = { 'NvimTree' },
        buftype = { 'terminal', 'quickfix' }
      }
    }
  end }
  use { 'rcarriga/nvim-notify' }                -- Floating notifications popups
  use { 'NarutoXY/dim.lua' }                    -- It's kinda buggy
  use { 'akinsho/toggleterm.nvim', config = GetConfig('toggleterm') }
  use { 'kevinhwang91/nvim-bqf', event = 'FileType qf', config = function()
    require('quickfix')                         -- Better quickfix
    require('bqf').setup {
      func_map = {
        prevfile  = '<C-k>',
        nextfile  = '<C-j>',
        fzffilter = '<C-p>',
        split     = '<C-s>',
      }
    }
  end }
  use { 'TimUntersberger/neogit' }              -- Git wrapper
  use { 'famiu/nvim-reload', cmd = {'Reload', 'Restart'} } -- Reloads Neovim config
end)

if fn.filereadable('~/.config/nvim/config.vim') then
  cmd 'source ~/.config/nvim/config.vim'
end

local utils = require('utils')
local map = utils.map
local feedkeys = utils.feedkeys
local autocmd = utils.autocmd
local visible_buffers = utils.visible_buffers

---------
-- Cmp --
---------
opt.completeopt = 'menuone,noselect'
local nvim_cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_disabled = nvim_cmp.config.disable
local cmp_insert = { behavior = nvim_cmp.SelectBehavior.Insert }

local function cmp_map(rhs, modes)
  if (modes == nil) then
    modes = {'i', 'c'}
  else if (type(modes) ~= 'table')
    then modes = {modes} end
  end
  return nvim_cmp.mapping(rhs, modes)
end

local function toggle_complete()
  return function()
    if nvim_cmp.visible() then
      nvim_cmp.close()
    else
      nvim_cmp.complete()
    end
  end
end

local function complete()
  local copilot_keys = fn['copilot#Accept']('')
  if nvim_cmp.visible() then
    nvim_cmp.mapping.confirm({select = true})()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif copilot_keys ~= '' then
    feedkeys(copilot_keys)
  else
    nvim_cmp.complete()
  end
end

local function cmdline_complete()
  if nvim_cmp.visible() then
    nvim_cmp.mapping.confirm({select = true})()
  else
    nvim_cmp.complete()
  end
end

local function join(tbl1, tbl2)
  local tbl3 = {}
  for _, item in ipairs(tbl1) do
    table.insert(tbl3, item)
  end
  for _, item in ipairs(tbl2) do
    table.insert(tbl3, item)
  end
  return tbl3
end

nvim_cmp.PreselectMode = true

local sources = {
  { name = 'luasnip', max_item_count = 5 },
  { name = 'nvim_lsp' },
  { name = 'nvim_lua' },
  { name = 'nvim_lsp_signature_help' },
  { name = 'path', option = { trailing_slash = true } },
  { name = 'buffer',
    max_item_count = 3,
    keyword_length = 2,
    option = {
      get_bufnrs = visible_buffers, -- Suggest words from all visible buffers
    },
  }
}

nvim_cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp_map(nvim_cmp.mapping.select_next_item(cmp_insert)),
    ['<C-k>'] = cmp_map(nvim_cmp.mapping.select_prev_item(cmp_insert)),
    ['<C-b>'] = cmp_map(nvim_cmp.mapping.scroll_docs(-4)),
    ['<C-f>'] = cmp_map(nvim_cmp.mapping.scroll_docs(4)),
    ['<C-Space>'] = cmp_map(toggle_complete(), {'i', 'c', 's'}),
    ['<Tab>'] = nvim_cmp.mapping({
      i = complete,
      c = cmdline_complete,
    }),
    ['<C-y>'] = cmp_disabled,
    ['<C-n>'] = cmp_disabled,
    ['<C-p>'] = cmp_disabled,
  },
  sources = nvim_cmp.config.sources(sources),
  formatting = {
    format = require('lspkind').cmp_format()
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  }
})

autocmd('FileType', {
  pattern = { 'markdown', 'text', 'tex', 'gitcommit' },
  callback = function()
    nvim_cmp.setup.buffer({
      sources = nvim_cmp.config.sources(join({{ name = 'cmp_tabnine' }}, sources))
    })
  end,
  group = 'TabNine'
})

-- Use buffer source for `/` (searching)
nvim_cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for `:`
nvim_cmp.setup.cmdline(':', {
  sources = nvim_cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})

-------------
-- Tabnine --
-------------
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
  max_num_results = 3,
  show_prediction_strength = true,
  ignored_file_types = {},
})

-------------
-- Copilot --
-------------
map('i', '<C-l>', 'copilot#Accept("")', { expr = true })
map('i', '<C-f>', 'copilot#Accept("")', { expr = true })
map('i', '<M-.>', '<Plug>(copilot-next)')
map('i', '<M-,>', '<Plug>(copilot-previous)')
g.copilot_assume_mapped = true
g.copilot_filetypes = { TelescopePrompt = false, DressingInput = false }

autocmd('InsertEnter', {
  callback = function()
    -- Copilot takes a while to load, so statusline waits for this variable
    -- TODO: try to lazy load instead when vim-plug has been replaced with
    -- packer.nvim
    g.insert_entered = true
  end,
  group = 'Copilot',
})

---------------
-- Telescope --
---------------
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
  vim.ui.input({ prompt = 'Grep string', default = fn.expand("<cword>") },
    function(value)
      if value ~= nil then
        require('telescope.builtin').grep_string({ search = value })
      end
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
telescope.load_extension('refactoring')
telescope.load_extension('notify')
telescope.load_extension('sessions_picker')

--------------
-- Dressing --
--------------
local d_input = require('dressing.input')
require('dressing').setup {
  select = {
    telescope = require('telescope.themes').get_dropdown()
  },
  input = {
    insert_only = false,
    relative = 'editor',
    default_prompt = ' ', -- Doesn't seem to work
  }
}

autocmd('Filetype', {
  pattern = 'DressingInput',
  callback = function()
    feedkeys('<Esc>V<C-g>', 'i') -- Enter input window in select mode
    map({'i', 's'}, '<C-j>', d_input.history_next, { buffer = true })
    map({'i', 's'}, '<C-k>', d_input.history_prev, { buffer = true })
    map({'s', 'n'}, '<C-c>', d_input.close,        { buffer = true })
    map('s',        '<CR>',  d_input.confirm,      { buffer = true })
  end,
  group = 'Dressing'
})

----------------
-- Treesitter --
----------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {'latex', 'vim'},
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['aF'] = '@function.outer',
        ['iF'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- Whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['>,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<,'] = '@parameter.inner',
      },
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}

-- Disable treesitter from highlighting errors (LSP does that anyway)
cmd 'highlight! link TSError Normal'

----------------
-- Diagnostics --
----------------
lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
  }
)

local function sign_define(name, symbol)
  fn.sign_define(name, {
    text   = symbol,
    texthl = name,
  })
end

sign_define('DiagnosticSignError', '')
sign_define('DiagnosticSignWarn',  '')
sign_define('DiagnosticSignHint',  '')
sign_define('DiagnosticSignInfo',  '')

----------------------
-- Indent blankline --
----------------------
require('indent_blankline').setup {
  char = '▏',
  show_first_indent_level = false,
  buftype_exclude = {'fzf', 'help'},
  filetype_exclude = {
    'markdown',
    'startify',
    'sagahover',
    'NvimTree',
    'lsp-installer',
    'toggleterm',
    'packer',
  }
}

--------------
-- Gitsigns --
--------------
local gitsigns = require('gitsigns')
require('gitsigns').setup {
  signs = {
    add          = {text = '│', hl = 'String'},
    change       = {text = '│', hl = 'Boolean'},
    changedelete = {text = '│', hl = 'Boolean'},
    delete       = {text = '▁', hl = 'Error'},
    topdelete    = {text = '▔', hl = 'Error'},
  },
  attach_to_untracked = false,
  on_attach = function()
    map({'n', 'x'}, '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>')
    map({'n', 'x'}, '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>')
    map('n',        '<leader>ghS', gitsigns.stage_buffer)
    map('n',        '<leader>ghR', gitsigns.reset_buffer)
    map('n',        '<leader>ghu', gitsigns.undo_stage_hunk)
    map('n',        '<leader>ghp', gitsigns.preview_hunk)
    map('n',        '<leader>gb',  function() return gitsigns.blame_line({
      full = true,
      ignore_whitespace = true,
    }) end)

    -- Next/previous hunk
    map('n', ']c', function()
      if opt.diff then
        feedkeys(']c', 'n')
      else
        gitsigns.next_hunk()
      end
    end)
    map('n', '[c', function()
      if opt.diff then
        feedkeys('[c', 'n')
      else
        gitsigns.prev_hunk()
      end
    end)

    -- Text objects
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
    map({'o', 'x'}, 'ah', gitsigns.select_hunk)
  end,
}
-- Workaround for bug where change highlight switches for some reason
cmd 'hi! link GitGutterChange DiffChange'
vim.opt.diffopt:append { 'algorithm:patience' } -- Use patience diff algorithm

------------------
-- Comment.nvim --
------------------
require('Comment').setup {
  toggler = {
    line = '<leader>cc',
    block = '<leader>cbb'
  },
  opleader = {
    line = '<leader>c',
  },
  extra = {
    above = '<leader>cO',
    below = '<leader>co',
    eol = '<leader>cA'
  },
  ignore = '^$', -- Ignore empty lines
  pre_hook = function(ctx)
    if vim.bo.filetype == 'typescriptreact' then
      local c_utils = require('Comment.utils')
      local ts_context_utils = require('ts_context_commentstring.utils')
      local type = ctx.ctype == c_utils.ctype.line and '__default' or '__multiline'
      local location

      if ctx.ctype == c_utils.ctype.block then
        location = ts_context_utils.get_cursor_location()
      elseif ctx.cmotion == c_utils.cmotion.v or ctx.cmotion == c_utils.cmotion.V then
        location = ts_context_utils.get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location
      })
    end
  end
}

local comment_api = require('Comment.api')
local function comment_map(modes, lhs, command, operator_pending)
  map(modes, lhs, function()
    comment_api.call(command)
    if not operator_pending then
      feedkeys('g@$')
    else
      feedkeys('g@')
    end
  end, command)
end

map('n', '<leader>C',  '<Plug>(comment_toggle_linewise)$')
map('n', '<leader>cB', '<Plug>(comment_toggle_blockwise)$')
map('n', '<leader>cb', '<Plug>(comment_toggle_blockwise)')
map('x', '<leader>b',  '<Plug>(comment_toggle_blockwise_visual)')
map('n', 'cm',         '<Plug>(comment_toggle_current_linewise)')
map('n', '<leader>cp', 'yycmp', {remap = true})

comment_map('n', '<leader>c>',   'comment_linewise_op', true)
comment_map('n', '<leader>c>>',  'comment_current_linewise_op')
comment_map('n', '<leader>cb>>', 'comment_current_blockwise_op')
comment_map('x', '<leader>>',    'comment_current_linewise_op')

comment_map('n', '<leader>c<',   'uncomment_linewise_op', true)
comment_map('n', '<leader>cu',   'uncomment_linewise_op', true)
comment_map('n', '<leader>c<<',  'uncomment_current_linewise_op')
comment_map('n', '<leader>cb<<', 'uncomment_current_blockwise_op')
comment_map('x', '<leader><',    'uncomment_current_linewise_op')

---------------
-- Rest.nvim --
---------------
require('rest-nvim').setup()

function _G.http_request()
  if api.nvim_win_get_width(api.nvim_get_current_win()) < 80 then
    cmd('wincmd s')
  else
    cmd('wincmd v')
  end
  cmd('edit ~/.config/nvim/http | set filetype=http | set buftype=')
end

cmd 'command! Http call v:lua.http_request()'

autocmd('FileType', {
  pattern = 'http',
  callback = function()
    map('n', '<CR>', '<Plug>RestNvim:w<CR>', { buffer = true })
    map('n', '<Esc>', '<cmd>BufferClose<CR><cmd>wincmd c<CR>', { buffer = true })
  end,
  group = 'RestNvim'
})

----------------------
-- Refactoring.nvim --
----------------------
local refactoring = require('refactoring')
refactoring.setup({})

map('x', 'gRe', function() return refactoring.refactor('Extract Function') end)
map('x', 'gRf', function() return refactoring.refactor('Extract Function To File') end)
map('x', '<leader>R', function()
  feedkeys('<Esc>', 'n')
  telescope.extensions.refactoring.refactors()
end, 'Select refactor')

--------------------
-- Indent-o-matic --
--------------------
require('indent-o-matic').setup {}

--------------
-- Miniyank --
--------------
map('n',        'p',     '<Plug>(miniyank-autoput)')
map('n',        'P',     '<Plug>(miniyank-autoPut)')
map({'n', 'x'}, '<M-p>', '<Plug>(miniyank-cycle)')
map({'n', 'x'}, '<M-P>', '<Plug>(miniyank-cycleback)')
map('x', 'p', '"_dPP', { remap = true })

--------------
-- Diffview --
--------------
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

----------------
-- Lightspeed --
----------------
g.lightspeed_no_default_keymaps = true
require('lightspeed').setup {
  exit_after_idle_msecs = { labeled = 1000 }
}

map({'n', 'x', 'o'}, 'zj',     '<Plug>Lightspeed_s',       'Lightspeed jump downwards')
map({'n', 'x', 'o'}, 'zk',     '<Plug>Lightspeed_S',       'Lightspeed jump upwards')
map({'n', 'x', 'o'}, '<CR>',   '<Plug>Lightspeed_omni_s',  'Lightspeed jump bidirectionally')
map({'n', 'x', 'o'}, '<S-CR>', '<Plug>Lightspeed_omni_gs', 'Lightspeed jump to window bidirectionally')

map('o', 'zJ', '<Plug>Lightspeed_x',  'Lightspeed jump downwards (inclusive op)')
map('o', 'zK', '<Plug>Lightspeed_X',  'Lightspeed jump upwards (inclusive op)')

-- Move default zj/zk bindings to ]z/[z
map('n', ']z', 'zj', 'Jump to next fold using ]z instead of zj')
map('n', '[z', 'zk', 'Jump to previous fold using [z instead of zk')

--------------
-- Winshift --
--------------
local function winshift(arg)
  return function()
    require('winshift').cmd_winshift(arg)
  end
end

map('n', '<C-w><C-m>', winshift())
map('n', '<C-w>m',     winshift())
map('n', '<C-w><C-x>', winshift('swap'))
map('n', '<C-w>x',     winshift('swap'))
map('n', '<C-w>M',     winshift('swap'))

map('n', '<C-M-H>', winshift('left'))
map('n', '<C-M-J>', winshift('down'))
map('n', '<C-M-K>', winshift('up'))
map('n', '<C-M-L>', winshift('right'))

-------------
-- Notify --
-------------
local notify = require('notify')
require('notify').setup {
  timeout = 2000,
}
vim.notify = notify

-- LSP window/showMessage
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local level = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]

  notify({ result.message }, level, {
    title = 'LSP | ' .. client.name,
    timeout = 10000,
    keep = function() return level == 'ERROR' or level == 'WARN' end,
  })
end

-------------
-- Dim.lua --
-------------
require('dim').setup() -- not working for some reason

---------
-- Git --
---------
local neogit = require('neogit')
neogit.setup {
  commit_popup = {
    kind = 'vsplit',
  },
  signs = {
    section = { '', '' },
    item = { '', '' },
  },
  integrations = { diffview = true  },
  disable_builtin_notifications = true,
  disable_commit_confirmation = true,
}

map('n', '<leader>gc', '<cmd>Neogit commit<CR>')
map('n', '<leader>gp', '<cmd>Neogit pull<CR>')
map('n', '<leader>gP', '<cmd>Neogit push<CR>')
map('n', '<leader>gr', '<cmd>Neogit rebase<CR>')
map('n', '<leader>gl', '<cmd>Neogit log<CR>')
map('n', '<leader>gB', '<cmd>Git blame<CR>', 'Git blame every line')
map('n', '<leader>gC', require('telescope.builtin').git_branches, 'Telescope git branch')
map('n', '<leader>gs', function() return neogit.open({
  cwd = vim.fn.expand('%:p:h'),
  kind = 'vsplit',
}) end, 'Neogit status')

-- TODO: replace with Neogit or Diffview diff once feature is available
map('n', '<leader>gd', function() call('GitDiff') end, 'Git diff current file')
cmd [[
  function! GitDiff() abort
    let tmp = g:bufferline.insert_at_end
    let g:bufferline.insert_at_end = v:false
    tabnew %
    exe 'Gvdiffsplit'
    exe 'BufferMovePrevious'
    windo set wrap
    let g:bufferline.insert_at_end = tmp
  endf
]]

vim.opt.fillchars = { diff = ' ' }

---------------------
-- General config --
---------------------
-- Commands
api.nvim_add_user_command(
  'Search',
  ':let @/="\\\\V" . escape(<q-args>, "\\\\\") | normal! n',
  { nargs = 1, desc = 'Search literally, with no regex' }
)

api.nvim_add_user_command(
  'CDHere',
  'cd %:p:h',
  { desc = "Change working directory to current file's" }
)

api.nvim_add_user_command(
  'YankPath',
  function()
    fn.setreg('+', fn.expand('%:~'))
    vim.notify('Yanked file path: ' .. fn.getreg('+'))
  end,
  { desc = "Yank current file's path" }
)

-- Mappings --
autocmd('CmdwinEnter', {
  callback = function()
    map('n', '<CR>',  '<CR>',   { buffer = true })
    map('n', '<Esc>', '<C-w>c', { buffer = true })
  end,
  group = 'mappings'
})

map('n', '<leader><C-t>', function()
  bo.bufhidden = 'delete' feedkeys('<C-t>', 'n')
end, 'Delete buffer and pop jump stack')

-- Disabled until TSLspOrganize and/or TSLspImportAll doesn't collide with
--     ['*.ts,*.tsx'] = function()
--       if b.format_on_write ~= false then
--         cmd 'TSLspOrganize'
--         cmd 'TSLspImportAll'
--       end
--     end
--   }
-- }

map('n', '<C-w><C-n>', '<cmd>vnew<CR>')
map('n', '<leader>N', function ()
  opt.relativenumber = not opt.relativenumber
  print('Relative numbers ' .. (opt.relativenumber and 'enabled' or 'disabled'))
end, 'Toggle relative numbers')
map('n', '<leader>W', function ()
  vim.o.wrap = not vim.o.wrap
  print('Line wrap ' .. (vim.o.wrap and 'enabled' or 'disabled'))
end, 'Toggle line wrap')
map('s', '<BS>', '<BS>i') -- By default <BS> puts you in normal mode

-- General autocmds --
autocmd('TextYankPost', { -- Highlight text object on yank
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
  end,
  group = 'HighlightYank'
})

-- Packer --
autocmd('BufEnter', {
  pattern = fn.stdpath('config') .. '/init.lua',
  callback = function ()
    map('n', '<F5>', ':source ~/.config/nvim/init.lua | PackerInstall<CR>', {
      buffer = true,
    })
  end
})

autocmd('BufWritePost', {
  pattern = 'init.lua',
  command = 'source <afile> | PackerCompile',
  group   = 'Packer'
})

-- TypeScript specific --
autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    vim.opt.matchpairs:append('<:>')
  end,
  group = 'TypeScript'
})
