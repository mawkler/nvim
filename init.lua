local opt, bo = vim.opt, vim.b
local cmd, fn, api = vim.cmd, vim.fn, vim.api

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

require('packer').startup(function()
  -- `use` packer config for plugin that's in an external module
  function Use(module)
    use(require(string.format('configs.%s', module)))
  end

  use { 'wbthomason/packer.nvim', opt = false }
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
  Use 'undotree'
  use { 'breuckelen/vim-resize',                -- Resizing with arrow keys
    cmd = {'CmdResizeUp', 'CmdResizeRight', 'CmdResizeDown', 'CmdResizeLeft'},
  }
  use { 'junegunn/vim-peekaboo' }               -- Register selection window
  use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
  use { 'RRethy/vim-hexokinase', run = 'make' } -- Displays the colours (rgb, etc.) in files
  Use 'startify'                                -- Nicer start screen
  use { 'DanilaMihailov/beacon.nvim', event = 'WinEnter' } -- Flash the cursor location on jump
  Use 'indent_blankline'                        -- Indent markers
  use { 'coreyja/fzf.devicon.vim',
    requires = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  }
  use { 'Xuyuanp/scrollbar.nvim', event = 'WinScrolled' }
  Use 'web_devicons'
  Use 'nvim_tree'                               -- File explorer
  use { 'romgrk/barbar.nvim' }                  -- Sexiest buffer tabline
  Use 'formatter'                               -- Auto formatting on save
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
  Use 'gitsigns'                                -- Git status in sign column
  Use 'lsp'                                     -- Built-in LSP
  Use 'luasnip'                                 -- Snippet engine
  use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path',         after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline',      after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' }
  use { 'tzachar/cmp-tabnine',
    run = './install.sh',
    after = 'nvim-cmp',
    config = function()
      local tabnine = require('cmp_tabnine.config')
      tabnine:setup {
        max_num_results = 3,
        show_prediction_strength = true,
        ignored_file_types = {},
      }
    end }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
  Use 'cmp'
  use { 'onsails/lspkind-nvim' }                -- VSCode-like completion icons
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  use { 'melkster/friendly-snippets' }          -- Snippet collection
  Use 'treesitter'
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  }
  Use 'trouble'                                 -- Nicer list of diagnostics
  use { 'b0o/schemastore.nvim'--[[ , ft = {'json', 'yaml'}  ]]}
  use { 'jvgrootveld/telescope-zoxide' }
  use { 'dhruvmanila/telescope-bookmarks.nvim' }
  use { 'nvim-telescope/telescope-cheat.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sqlite.lua' }
  use { 'JoseConseco/telescope_sessions_picker.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  Use 'telescope'                               -- Fuzzy finder
  Use 'dressing'                                -- Improves `vim.ui` interfaces
  use { 'MunifTanjim/nui.nvim', module_pattern = 'nui.*' }                -- UI component library
  use { 'milisims/nvim-luaref' }                -- Vim :help reference for lua
  use { 'folke/lua-dev.nvim' }                  -- Lua signature help, docs and completion
  use { 'ethanholz/nvim-lastplace', config = function()
    require('nvim-lastplace').setup {}          -- Restore cursor position
  end }
  Use 'dial'                                    -- Enhanced increment/decrement
  Use 'comment'
  Use 'rest'                                    -- Sending HTTP requests
  Use 'dap'                                     -- UI for nvim-dap
  use { 'Pocco81/DAPInstall.nvim'--[[ , module_pattern = 'dap-install.*'   ]]} -- Managing debuggers
  use { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  Use 'onedark'
  Use 'refactoring'
  use { 'Darazaki/indent-o-matic',              -- Automatic indentation detection
    config = function() return require('indent-o-matic').setup {} end
  }
  use { 'lewis6991/impatient.nvim' }            -- Improve startup time for Neovim
  Use 'miniyank'                                -- Cycle register history
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat', fn = 'repeat#set' }
  Use 'quick_scope'
  use { 'andymass/vim-matchup', keys = '%' }    -- Ads additional `%` commands
  Use 'autopairs'
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
  use { 'AndrewRadev/dsf.vim', keys = {'dsf', 'dsF'}, opt = false }
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
  Use 'copilot'                                 -- GitHub Copilot
  use { 'tvaintrob/bicep.vim', ft = 'bicep' }
  use { 'luukvbaal/stabilize.nvim', event = 'WinNew', config = function()
    return require('stabilize').setup()
  end }
  Use 'diffview'                                -- Git diff and file history
  Use 'lightspeed'                              -- Moving cursor anywhere
  Use 'winshift'                                -- Improved window movement
  Use 'notify'                                  -- Floating notifications popups
  use { 'NarutoXY/dim.lua',                     -- Dim unused words
    config = function() return require('dim').setup() end,
  }
  Use 'toggleterm'                              -- Toggleable terminal
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
  Use 'git'                                     -- Git wrapper
  use { 'famiu/nvim-reload', cmd = {'Reload', 'Restart'} } -- Reloads Neovim config
end)

-- Other configs
require('configs.diagnostics')

if fn.filereadable('~/.config/nvim/config.vim') then
  cmd 'source ~/.config/nvim/config.vim'
end

local utils = require('utils')
local map, feedkeys, autocmd = utils.map, utils.feedkeys, utils.autocmd

---------------------
-- General config --
---------------------
-- Commands
api.nvim_create_user_command(
  'Search',
  ':let @/="\\\\V" . escape(<q-args>, "\\\\\") | normal! n',
  { nargs = 1, desc = 'Search literally, with no regex' }
)

api.nvim_create_user_command(
  'CDHere',
  'cd %:p:h',
  { desc = "Change working directory to current file's" }
)

api.nvim_create_user_command(
  'YankPath',
  function()
    fn.setreg('+', fn.expand('%:~'))
    vim.notify('Yanked file path: ' .. fn.getreg('+'))
  end,
  { desc = "Yank current file's path" }
)

api.nvim_create_user_command(
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
map({'n', 'i', 'v', 'o', 't'}, '<C-m>', '<CR>', { remap = true })

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
