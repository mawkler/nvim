-- Should be loaded before any other plugin
-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient')

-- Better `require`
require('import')

import('packer', function(packer) packer.startup { function()
  -- Import plugin config from external module in lua/configs/
  function Use(module)
    import(string.format('configs.%s', module), use)
  end

  Use 'import'                                  -- A better Lua 'require()'
  use { 'wbthomason/packer.nvim' }              -- Plugin manager
  use { 'tpope/vim-fugitive',                   -- :Git commands
    requires = 'tpope/vim-dispatch',            -- Asynchronous `:Gpush`, etc.
    cmd = {'G', 'Git', 'Gvdiffsplit'},
  }
  Use 'eunuch'
  use { 'tpope/vim-abolish', cmd = {'Abolish', 'S'} }
  use { 'inkarkat/vim-visualrepeat', requires = 'inkarkat/vim-ingo-library' }
  use { 'milkypostman/vim-togglelist',          -- Mapping to toggle QuickFix window
    fn = 'ToggleQuickfixList',
  }
  use { 'kana/vim-niceblock',                   -- Improves visual mode
    event = 'ModeChanged *:[vV]',
  }
  use { 'kana/vim-textobj-syntax' }
  use { 'haya14busa/vim-textobj-function-syntax' }
  use { 'PeterRincker/vim-argumentative' }      -- Adds mappings for swapping arguments
  use { 'AndrewRadev/splitjoin.vim', keys = {'n', 'gS', 'gJ'} }
  use { 'junegunn/vim-easy-align', keys = '<Plug>(EasyAlign)' }
  use { 'dkarter/bullets.vim', ft = 'markdown' }-- Autocomplete markdown lists, etc.
  use { 'Julian/vim-textobj-variable-segment',  -- camelCase and snake_case text objects
    keys = {{'o', 'iv'}, {'o', 'av'}},
  }
  use { 'wsdjeg/vim-fetch' }                    -- Line and column position when opening file
  use { 'meain/vim-printer', keys = {'n', 'gp'} }
  Use 'lens'
  use { 'Ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryLookupCurrentWord' }
  Use 'undotree'
  -- use { 'breuckelen/vim-resize',                -- Resizing with arrow keys
  --   cmd = {'CmdResizeUp', 'CmdResizeRight', 'CmdResizeDown', 'CmdResizeLeft'},
  -- }
  -- Use 'smart_splits'
  use { 'junegunn/vim-peekaboo' }               -- Register selection window
  use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
  use { 'RRethy/vim-hexokinase', run = 'make' } -- Displays colour values
  Use 'startify'                                -- Nicer start screen
  Use 'beacon'                                  -- Flash cursor jump
  Use 'indent_blankline'                        -- Indent markers
  use { 'coreyja/fzf.devicon.vim',
    requires = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  }
  use { 'Xuyuanp/scrollbar.nvim', event = 'WinScrolled' }
  Use 'web_devicons'
  Use 'nvim_tree'                               -- File explorer
  Use 'barbar'                                  -- Sexiest buffer tabline
  Use 'formatter'                               -- Auto formatting on save
  Use 'neoscroll'                               -- Smooth scrolling animations
  Use 'feline'                                  -- Statusline framework
  Use 'incline'                                 -- Floating winbar
  Use 'fidget'                                  -- LSP progress indicator
  Use 'gitsigns'                                -- Git status in sign column
  Use 'lsp'                                     -- Built-in LSP
  Use 'luasnip'                                 -- Snippet engine
  use { 'saadparwaiz1/cmp_luasnip',            after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp',                after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer',                  after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path',                    after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline',                 after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lua',                after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
  Use 'cmp_tabnine'
  Use 'cmp'
  use { 'melkster/friendly-snippets' }          -- Snippet collection
  Use 'treesitter'
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  }
  Use 'trouble'                                 -- Nicer list of diagnostics
  Use 'telescope'                               -- Fuzzy finder
  Use 'dressing'                                -- Improves `vim.ui` interfaces
  use { 'MunifTanjim/nui.nvim',                 -- UI component library
    module_pattern = 'nui.*',
  }
  use { 'milisims/nvim-luaref' }                -- Vim :help reference for lua
  use { 'ethanholz/nvim-lastplace',             -- Restore cursor position
    config = function() require('utils').plugin_setup('nvim-lastplace', {}) end
  }
  Use 'dial'                                    -- Enhanced increment/decrement
  Use 'comment'
  Use 'rest'                                    -- Sending HTTP requests
  Use 'dap'                                     -- UI for nvim-dap
  Use 'overseer'                                -- Task runner
  -- use { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  Use 'onedark'
  Use 'refactoring'
  use { 'Darazaki/indent-o-matic',              -- Automatic indent detection
    config = function() require('utils').plugin_setup('indent-o-matic', {}) end
  }
  use { 'lewis6991/impatient.nvim' }            -- Improve startup time for Neovim
  Use 'miniyank'                                -- Cycle register history
  Use 'surround'
  use { 'tpope/vim-repeat', fn = 'repeat#set' }
  Use 'quick_scope'
  use { 'andymass/vim-matchup', keys = {'n', '%'} } -- Ads additional `%` commands
  Use 'autopairs'
  use { 'junegunn/fzf.vim', cmd = {'Ag', 'Rg'} }
  use { 'vim-scripts/capslock.vim' }            -- Adds caps lock mapping to insert mode
  use { 'vim-scripts/StripWhiteSpaces', event = 'BufWrite' }
  Use 'git_conflict'                            -- Git conflict mappings
  use { 'kana/vim-textobj-user' }
  use { 'kana/vim-textobj-function' }
  use { 'kana/vim-textobj-line' }
  use { 'kana/vim-textobj-entire' }
  use { 'lervag/vimtex', ft = {'tex', 'latex'} }
  Use 'indent_tools'
  Use 'targets'
  use { 'romainl/vim-cool' }                    -- Better search highlighting behaviour
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
  use { 'coachshea/vim-textobj-markdown', ft = 'markdown' }
  use { 'tommcdo/vim-exchange' }                -- Swapping two text objects
  Use 'highlighturl'
  use { 'AndrewRadev/bufferize.vim',            -- Send command output to buffer
    cmd = 'Bufferize',
  }
  Use 'vim_session'
  use { 'rhysd/vim-grammarous' }                -- LanguageTool grammar checking
  Use 'copilot'                                 -- GitHub Copilot
  use { 'tvaintrob/bicep.vim', ft = 'bicep' }
  use { 'luukvbaal/stabilize.nvim', event = 'WinNew',
    config = function() require('utils').plugin_setup('stabilize') end
  }
  Use 'diffview'                                -- Git diff and file history
  Use 'leap'                                    -- Move cursor anywhere
  Use 'winshift'                                -- Improved window movement
  Use 'notify'                                  -- Floating notifications popups
  use { 'NarutoXY/dim.lua', config = function() -- Dim unused words
    require('utils').plugin_setup('dim')
  end }
  Use 'toggleterm'                              -- Toggleable terminal
  Use 'bqf'
  Use 'qf'
  Use 'git'                                     -- Git wrapper
  use { 'famiu/nvim-reload',                    -- Reloads Neovim config
    cmd = {'Reload', 'Restart'},
  }
  Use 'template_string'                         -- Automatic template string
  use { 'chrisbra/csv.vim', ft = 'csv' }        -- CSV highlighting, etc.
end, config = {
  profile = {
    enable = true,
  },
  display = {
    keybindings = {
      quit = '<Esc>',
      toggle_info = '<Space>',
    },
  }
}} end)

if vim.fn.getenv('NVIM_AUTOCOMPILE') == 'true' then
  vim.api.nvim_create_augroup('Packer', {})
  vim.api.nvim_create_autocmd('VimEnter', {
    command = 'PackerCompile',
    group = 'Packer',
  })
end

-- Other configs
import('configs.options')
import('configs.keymaps')
import('configs.autocmds')
import('configs.commands')
import('configs.diagnostics')
import('configs.neovide')
pcall(vim.cmd, 'source ~/.config/nvim/config.vim')
