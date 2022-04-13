local opt, g, bo = vim.opt, vim.g, vim.b
local cmd, fn, api, lsp = vim.cmd, vim.fn, vim.api, vim.lsp

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
function Config(module)
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
  use { 'dkarter/bullets.vim', ft = 'markdown' }-- Autocomplete markdown lists, etc.
  use { 'Julian/vim-textobj-variable-segment',  -- camelCase and snake_case text objects
    keys = {{'o', 'iv'}, {'o', 'av'}},
  }
  use { 'wsdjeg/vim-fetch' }                    -- Line and column position when opening file
  use { 'meain/vim-printer', keys = 'gp' }
  use { 'camspiers/lens.vim' }                  -- Automatic window resizing
  use { 'Ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryLookupCurrentWord' }
  use { 'mbbill/undotree',
    keys = '<leader>u',
    cmd = {'UndoTreeShow', 'UndoTreeToggle'},
    config = Config('undotree'),
  }
  use { 'breuckelen/vim-resize',                -- Resizing with arrow keys
    cmd = {'CmdResizeUp', 'CmdResizeRight', 'CmdResizeDown', 'CmdResizeLeft'},
  }
  use { 'junegunn/vim-peekaboo' }               -- Register selection window
  use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
  use { 'RRethy/vim-hexokinase', run = 'make' } -- Displays the colours (rgb, etc.) in files
  use { 'mhinz/vim-startify',                   -- Nicer start screen
    requires = 'kyazdani42/nvim-web-devicons',
    config = Config('startify'),
  }
  use { 'DanilaMihailov/beacon.nvim', event = 'WinEnter' } -- Flash the cursor location on jump
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'coreyja/fzf.devicon.vim',
    requires = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  }
  use { 'Xuyuanp/scrollbar.nvim', event = 'WinScrolled' }
  use { 'kyazdani42/nvim-web-devicons', config = Config('web-devicons') }
  use { 'kyazdani42/nvim-tree.lua',             -- File explorer
    after = 'nvim-web-devicons',
    -- module_pattern = 'nvim-tree.*',
    config = Config('nvim-tree')
  }
  use { 'romgrk/barbar.nvim' }                  -- Sexiest buffer tabline
  use { 'mhartington/formatter.nvim',           -- Auto formatting on save
    module = 'formatter',
    config = Config('formatter'),
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
    require('fidget').setup {                   -- LSP progress in the bottom right corner
      text = { spinner = 'dots', done = '' }
    }
  end }
  use { 'lewis6991/gitsigns.nvim' }             -- Git status in sign column
  use { 'neovim/nvim-lspconfig',                -- Enables built-in LSP
    requires = 'williamboman/nvim-lsp-installer',-- Adds LspInstall command
    config = Config('lsp')
  }
  use { 'L3MON4D3/LuaSnip',                     -- Snippet engine
    -- module = 'luasnip',
    config = Config('luasnip')
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'tzachar/cmp-tabnine', run = './install.sh' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
  use {
    'hrsh7th/nvim-cmp',
    config = Config('cmp'),
    event = 'InsertEnter'
  }
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
    config = Config('trouble'),
  }
  use { 'b0o/schemastore.nvim'--[[ , ft = {'json', 'yaml'}  ]]}
  use { 'jvgrootveld/telescope-zoxide' }
  use { 'dhruvmanila/telescope-bookmarks.nvim' }
  use { 'nvim-telescope/telescope-cheat.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sqlite.lua' }
  use { 'JoseConseco/telescope_sessions_picker.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim',        -- Fuzzy finder
    config = Config('telescope'),
    module_pattern = 'telescope%..*',
    requires =  {
      {'nvim-lua/popup.nvim', module_pattern = 'popup%..*'},
      {'nvim-lua/plenary.nvim'}
    },
  }
  use { 'stevearc/dressing.nvim',               -- Improves `vim.ui` interfaces
    config = Config('dressing')
  }
  use { 'MunifTanjim/nui.nvim', module_pattern = 'nui.*' }                -- UI component library
  use { 'milisims/nvim-luaref' }                -- Vim :help reference for lua
  use { 'folke/lua-dev.nvim' }                  -- Lua signature help, docs and completion
  use { 'ethanholz/nvim-lastplace', config = function()
    require('nvim-lastplace').setup()           -- Reopen files at last edit position
  end }
  use { 'monaqa/dial.nvim',                     -- Enhanced increment/decrement
    -- module_pattern = 'dial%.command.*',
    config = Config('dial')
  }
  use { 'numToStr/Comment.nvim', branch = 'plug' } -- TODO: remove `branch` once merged
  use { 'NTBBloodbath/rest.nvim'--[[ , cmd = 'Http'  ]]}-- For sending HTTP requests
  use { 'mfussenegger/nvim-dap',                -- Debugger client
    requires = 'rcarriga/nvim-dap-ui',          -- UI for nvim-dap
    config = Config('dap'),
  }
  use { 'Pocco81/DAPInstall.nvim'--[[ , module_pattern = 'dap-install.*'   ]]} -- Managing debuggers
  use { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  use { 'ful1e5/onedark.nvim', config = Config('onedark') }
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
    event = 'InsertEnter' ,
    config = Config('autopairs')
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
  use {                                         -- GitHub Copilot
    'github/copilot.vim',
    event = 'InsertEnter',
    config = Config('copilot')
  }
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
  use { 'akinsho/toggleterm.nvim', config = Config('toggleterm') }
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
  use { 'TimUntersberger/neogit', config = Config('git') } -- Git wrapper
  use { 'famiu/nvim-reload', cmd = {'Reload', 'Restart'} } -- Reloads Neovim config
end)

if fn.filereadable('~/.config/nvim/config.vim') then
  cmd 'source ~/.config/nvim/config.vim'
end

local utils = require('utils')
local map, feedkeys, autocmd = utils.map, utils.feedkeys, utils.autocmd

----------------
-- Treesitter --
----------------
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
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
  require('telescope').extensions.refactoring.refactors()
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

api.nvim_add_user_command(
  'YankPathRelative',
  function()
    fn.setreg('+', fn.expand('%'))
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
