local use = require('utils').use

-- General configs
require('configs.options')
require('configs.keymaps')
require('configs.autocmds')
require('configs.commands')
require('configs.diagnostics')
require('configs.neovide')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',                             -- Package manager
  { 'tpope/vim-fugitive',                        -- :Git commands
    dependencies = 'tpope/vim-dispatch',         -- Asynchronous `:Gpush`, etc.
    cmd = { 'G', 'Git', 'Gvdiffsplit' },
  },
  use 'eunuch',
  { 'tpope/vim-abolish', cmd = {'Abolish', 'S'} },
  { 'inkarkat/vim-visualrepeat',
    dependencies = { 'inkarkat/vim-ingo-library', 'tpope/vim-repeat' },
    event = 'ModeChanged *:[vV]',
  },
  { 'milkypostman/vim-togglelist',               -- Toggle quickfix window
    event = 'QuickFixCmdPre',
  },
  { 'kana/vim-niceblock',                        -- Improves visual mode
    event = 'ModeChanged *:[vV]',
  },
  use 'treesj',                                  -- Multiline split
  { 'junegunn/vim-easy-align',                   -- Align characters vertically
    dependencies = 'tpope/vim-repeat',
    keys = '<Plug>(EasyAlign)'
  },
  use 'autolist',                                -- Autocomplete lists
  { 'wsdjeg/vim-fetch', event = 'VeryLazy' },    -- Line and column position when opening file
  use 'printer',                                 -- Print text-object
  use 'windows',                                 -- Automatic window resizing
  use 'undotree',
  use 'smart-splits',                            -- Better resizing mappings
  use 'cheat',                                   -- cheat.sh
  use 'nvim-colorizer',                          -- Display colour values
  use 'alpha',                                   -- Nicer start screen
  use 'beacon',                                  -- Flash cursor jump
  use 'indent-blankline',                        -- Indent markers
  use 'mini-indentscope',                        -- Indentation scope
  use 'fzf',                                     -- Fuzzy finder
  use 'scrollview',                              -- Scrollbar
  use 'nvim-web-devicons',                       -- File icons
  use 'nvim-tree',                               -- File explorer
  use 'oil',
  use 'barbar',                                  -- Sexiest buffer tabline
  use 'null-ls',                                 -- Autoformatting, etc.
  use 'neoscroll',                               -- Smooth scrolling animations
  use 'feline',                                  -- Statusline framework
  use 'barbecue',                                -- Treesitter breadcrumbs
  use 'fidget',                                  -- LSP progress indicator
  use 'gitsigns',                                -- Git status in sign column
  use 'mason',                                   -- LSP/DAP/etc. package manager
  use 'lsp',                                     -- Built-in LSP
  use 'lsp-inlay-hints',                         -- LSP inlay hints
  use 'tsc',                                     -- TypeScript type checking
  use 'luasnip',                                 -- Snippet engine
  use 'cmp-tabnine',                             -- Tabnine autocompletion
  use 'cmp',                                     -- Autocompletion
  use 'treesitter',
  { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'VeryLazy' },
  { 'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'},
  },
  use 'trouble',                                 -- Nicer list of diagnostics
  use 'telescope',                               -- Fuzzy finder
  use 'dressing',                                -- Improves `vim.ui` interfaces
  use 'noice',                                   -- Nicer UI features
  { 'milisims/nvim-luaref', event = 'VeryLazy' },-- Vim :help reference for lua
  use 'lastplace',                               -- Restore cursor position
  use 'dial',                                    -- Enhanced increment/decrement
  use 'comment',
  use 'rest',                                    -- Sending HTTP requests
  use 'dap',                                     -- Debugger
  use 'dap-ui',                                  -- UI for nvim-dap
  use 'overseer',                                -- Task runner
  -- { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  use 'onedark',
  use 'catppuccin',
  use 'refactoring',
  use 'guess-indent',
  use 'yanky',                                   -- Cycle register history, etc.
  use 'surround',
  use 'eyeliner',                                -- Highlight uniques on f/F/t/T
  use 'matchup',                                 -- Adds additional `%` commands
  use 'ultimate-autopair',                       -- Auto-close brackets, etc.
  { 'vim-scripts/capslock.vim', event = 'InsertEnter' },
  { 'vim-scripts/StripWhiteSpaces', event = 'BufWrite' },
  use 'git-conflict',                            -- Git conflict mappings
  use 'vim-textobj',                             -- Custom text objects
  use 'vimtex',                                  -- LaTeX utilities
  use 'indent-tools',                            -- Indent text objects
  use 'ai',                                      -- next/previous text objects
  use 'hlsearch',                                -- Auto remove search highlights
  use 'markdown-togglecheck',
  { 'coachshea/vim-textobj-markdown',            -- Markdown text-objects
    dependencies = 'kana/vim-textobj-user',
    ft = 'markdown'
  },
  use 'substitute',                              -- Replace/exchange operators
  use 'highlighturl',
  use 'messages',                                -- Floating :messages window
  use 'possession',                              -- Session manager
  use 'copilot',                                 -- GitHub Copilot
  { 'tvaintrob/bicep.vim', ft = 'bicep' },
  use 'diffview',                                -- Git diff and file history
  use 'leap',                                    -- Move cursor anywhere
  use 'winshift',                                -- Improved window movement
  use 'notify',                                  -- Floating notifications popups
  use 'toggleterm',                              -- Toggleable terminal
  use 'term-edit',                               -- Better editing in :terminal
  use 'bqf',                                     -- Better quickfix
  use 'qf',                                      -- Quickfix utilities
  use 'neogit',                                  -- Git wrapper
  use 'blame',                                   -- Git blame file
  use 'reloader',                                -- Hot reload Neovim config
  use 'template-string',                         -- Automatic template string
  use 'csv',                                     -- CSV highlighting, etc.
  use 'modicator',                               -- Line number mode indicator
  { 'jghauser/mkdir.nvim',                       -- Create missing folders on :w
    event = 'CmdlineEnter'
  },
  use 'unception',                               -- Open files in Neovim from terminal
  use 'git-worktree',                            -- Manage git worktrees
  use 'tsnode-marker',                           -- Highlight code fence context
  use 'octo',                                    -- GitHub client
  use 'other',                                   -- Go to alternate file
  use 'neotest',                                 -- Testing framework
  use 'package-info',                            -- Show package.json versions
  use 'output-panel',                            -- LSP logs panel
  use 'typst',                                   -- Typst highlighting, etc.
  use 'zk',                                      -- Zettlekasten (note taking)
  use 'crates',                                  -- Cargo.toml helper
}

require('lazy').setup({
  spec = plugins,
  install = {
    colorscheme = { 'onedark' },
  },
})

vim.cmd.source('~/.config/nvim/config.vim')
