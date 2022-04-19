-- Should be loaded before any other plugin
-- Remove once https://github.com/neovim/neovim/pull/15436 gets merged
require('impatient')

require('packer').init {
  opt_default = true, -- Set to make loading plugins optional by default
  display = {
    keybindings = {
      quit = '<Esc>',
    }
  }
}

require('packer').startup(function()
  -- `use` packer config for plugin that's in an external module
  function Use(module)
    if type(module) == 'string' then
      module = require(string.format('configs.%s', module))
    elseif type(module) ~= 'table' then
      error('Invalid argument type')
    end

    if type(module.requires) == 'string' then
      module.requires = {{ module.requires, opt = false }}
    elseif type(module.requires) == 'table' then
      local requires = {}
      for _, required in pairs(module.requires) do
        table.insert(requires, { required, opt = false })
      end
      module.requires = requires
    end

    module.opt = false
    print(vim.inspect(module))
    use(module)
  end

  Use { 'wbthomason/packer.nvim', opt = false }
  Use { 'tpope/vim-fugitive',                   -- :Git commands
    requires = {'tpope/vim-dispatch' },            -- Asynchronous `:Gpush`, etc.
    cmd = {'G', 'Git', 'Gvdiffsplit'},
  }
  Use { 'tpope/vim-eunuch' }
  Use { 'tpope/vim-abolish', cmd = {'Abolish', 'S'} }
  Use { 'inkarkat/vim-visualrepeat', requires = {'inkarkat/vim-ingo-library' } }
  Use { 'milkypostman/vim-togglelist',          -- Mapping to toggle QuickFix window
    fn = 'ToggleQuickfixList',
  }
  Use { 'kana/vim-niceblock',                   -- Improves visual mode
    event = 'ModeChanged *:[vV]',
  }
  Use { 'kana/vim-textobj-syntax' }
  Use { 'haya14busa/vim-textobj-function-syntax' }
  Use { 'PeterRincker/vim-argumentative' }      -- Adds mappings for swapping arguments
  Use { 'AndrewRadev/splitjoin.vim', keys = 'gS' }
  Use { 'junegunn/vim-easy-align', keys = '<Plug>(EasyAlign)' }
  Use { 'dkarter/bullets.vim', ft = 'markdown' }-- Autocomplete markdown lists, etc.
  Use { 'Julian/vim-textobj-variable-segment',  -- camelCase and snake_case text objects
    keys = {{'o', 'iv'}, {'o', 'av'}},
  }
  Use { 'wsdjeg/vim-fetch' }                    -- Line and column position when opening file
  Use { 'meain/vim-printer', keys = 'gp' }
  Use { 'camspiers/lens.vim' }                  -- Automatic window resizing
  Use { 'Ron89/thesaurus_query.vim', cmd = 'ThesaurusQueryLookupCurrentWord' }
  Use 'undotree'
  Use { 'breuckelen/vim-resize',                -- Resizing with arrow keys
    cmd = {'CmdResizeUp', 'CmdResizeRight', 'CmdResizeDown', 'CmdResizeLeft'},
  }
  Use { 'junegunn/vim-peekaboo' }               -- Register selection window
  Use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
  Use { 'RRethy/vim-hexokinase', run = 'make' } -- Displays colour values
  Use 'startify'                                -- Nicer start screen
  Use { 'DanilaMihailov/beacon.nvim',           -- Flash the cursor location on jump
    event = 'WinEnter',
  }
  Use 'indent_blankline'                        -- Indent markers
  Use { 'coreyja/fzf.devicon.vim',
    requires = {'junegunn/fzf.vim', 'kyazdani42/nvim-web-devicons'},
    cmd = 'FilesWithDevicons',
  }
  Use { 'Xuyuanp/scrollbar.nvim', event = 'WinScrolled' }
  Use 'web_devicons'
  Use 'nvim_tree'                               -- File explorer
  Use { 'romgrk/barbar.nvim' }                  -- Sexiest buffer tabline
  Use 'formatter'                               -- Auto formatting on save
  Use 'neoscroll'                               -- Smooth scrolling animations
  Use 'feline'                                  -- Statusline framework
  Use 'fidget'                                  -- LSP progress indicator
  Use 'gitsigns'                                -- Git status in sign column
  Use 'lsp'                                     -- Built-in LSP
  Use 'luasnip'                                 -- Snippet engine
  Use { 'saadparwaiz1/cmp_luasnip',            after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-nvim-lsp',                after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-buffer',                  after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-path',                    after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-cmdline',                 after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-nvim-lua',                after = 'nvim-cmp' }
  Use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
  Use 'cmp_tabnine'
  Use 'cmp'
  Use { 'onsails/lspkind-nvim' }                -- VSCode-like completion icons
  Use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  Use { 'melkster/friendly-snippets' }          -- Snippet collection
  Use 'treesitter'
  Use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  Use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  Use { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  }
  Use 'trouble'                                 -- Nicer list of diagnostics
  Use { 'jvgrootveld/telescope-zoxide' }
  Use { 'dhruvmanila/telescope-bookmarks.nvim' }
  Use { 'nvim-telescope/telescope-cheat.nvim' }
  Use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  Use { 'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sqlite.lua' }
  Use { 'JoseConseco/telescope_sessions_picker.nvim' }
  Use { 'nvim-lua/plenary.nvim' }
  Use 'telescope'                               -- Fuzzy finder
  Use 'dressing'                                -- Improves `vim.ui` interfaces
  Use { 'MunifTanjim/nui.nvim',                 -- UI component library
    module_pattern = 'nui.*',
  }
  Use { 'milisims/nvim-luaref' }                -- Vim :help reference for lua
  Use { 'folke/lua-dev.nvim' }                  -- Lua signature help, docs and completion
  Use { 'ethanholz/nvim-lastplace',             -- Restore cursor position
    config = function() require('nvim-lastplace').setup {} end
  }
  Use 'dial'                                    -- Enhanced increment/decrement
  Use 'comment'
  Use 'rest'                                    -- Sending HTTP requests
  Use 'dap'                                     -- UI for nvim-dap
  Use { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  Use 'onedark'
  Use 'refactoring'
  Use { 'Darazaki/indent-o-matic',              -- Automatic indentation detection
    config = function() return require('indent-o-matic').setup {} end
  }
  Use { 'lewis6991/impatient.nvim' }            -- Improve startup time for Neovim
  Use 'miniyank'                                -- Cycle register history
  Use { 'tpope/vim-surround' }
  Use { 'tpope/vim-repeat', fn = 'repeat#set' }
  Use 'quick_scope'
  Use { 'andymass/vim-matchup', keys = '%' }    -- Ads additional `%` commands
  Use 'autopairs'
  Use { 'junegunn/fzf.vim', cmd = {'Ag', 'Rg'} }
  Use { 'vim-scripts/capslock.vim' }            -- Adds caps lock mapping to insert mode
  Use { 'vim-scripts/StripWhiteSpaces', event = 'BufWrite' }
  Use { 'inkarkat/vim-ConflictMotions',
    requires = {'inkarkat/vim-ingo-library', 'inkarkat/vim-CountJump'},
  }
  Use { 'kana/vim-textobj-user' }
  Use { 'kana/vim-textobj-function' }
  Use { 'kana/vim-textobj-line' }
  Use { 'kana/vim-textobj-entire' }
  Use { 'lervag/vimtex', ft = {'tex', 'latex'} }
  Use { 'AndrewRadev/dsf.vim', keys = {{'n', 'dsf'}, {'n', 'dsF'}} }
  Use { 'michaeljsmith/vim-indent-object' }
  Use { 'wellle/targets.vim' }                  -- Adds arguments, etc. as text objects
  Use { 'romainl/vim-cool' }                    -- Better search highlighting behaviour
  Use { 'plasticboy/vim-markdown', ft = 'markdown' }
  Use { 'coachshea/vim-textobj-markdown', ft = 'markdown' }
  Use { 'tommcdo/vim-exchange' }                -- Swapping two text objects
  Use { 'itchyny/vim-highlighturl' }            -- Highlights URLs everywhere
  Use { 'AndrewRadev/bufferize.vim',            -- Send command output to buffer
    cmd = 'Bufferize',
  }
  Use 'vim_session'
  Use { 'rhysd/vim-grammarous' }                -- LanguageTool grammar checking
  Use 'copilot'                                 -- GitHub Copilot
  Use { 'tvaintrob/bicep.vim', ft = 'bicep' }
  Use { 'luukvbaal/stabilize.nvim', event = 'WinNew', config = function()
    return require('stabilize').setup()
  end }
  Use 'diffview'                                -- Git diff and file history
  Use 'lightspeed'                              -- Moving cursor anywhere
  Use 'winshift'                                -- Improved window movement
  Use 'notify'                                  -- Floating notifications popups
  Use { 'NarutoXY/dim.lua',                     -- Dim unused words
    config = function() return require('dim').setup() end,
  }
  Use 'toggleterm'                              -- Toggleable terminal
  Use 'bqf'
  Use 'git'                                     -- Git wrapper
  Use { 'famiu/nvim-reload',                    -- Reloads Neovim config
    cmd = {'Reload', 'Restart'},
  }
end)

-- Other configs
require('configs.keymaps')
require('configs.autocmds')
require('configs.commands')
require('configs.diagnostics')

if vim.fn.filereadable('~/.config/nvim/config.vim') then
  vim.cmd 'source ~/.config/nvim/config.vim'
end
