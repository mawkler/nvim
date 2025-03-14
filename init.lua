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
  'folke/lazy.nvim',          -- Package manager
  use 'eunuch',               -- :Rename, :Delete, etc.
  use 'fugitive',             -- :Git commands
  use 'visualrepeat',         -- Repeat over visual selection
  use 'easy-align',           -- Align characters vertically
  use 'treesj',               -- Multiline split
  use 'autolist',             -- Autocomplete lists
  use 'printer',              -- Print text-object
  use 'windows',              -- Automatic window resizing
  use 'undotree',             -- Tree of file histories
  use 'smart-splits',         -- Better resizing mappings
  use 'cheat',                -- cheat.sh
  use 'nvim-colorizer',       -- Display colour values
  use 'alpha',                -- Nicer start screen
  use 'indent-blankline',     -- Indent markers
  use 'mini-indentscope',     -- Indentation scope
  use 'indent-tools',         -- Indent-based navigation
  use 'fzf',                  -- Fuzzy finder
  use 'nvim-web-devicons',    -- File icons
  use 'nvim-tree',            -- File explorer
  use 'oil',                  -- Single directory file browser
  use 'barbar',               -- Sexiest buffer tabline
  use 'conform',              -- Autoformatting
  use 'neoscroll',            -- Smooth scrolling animations
  use 'feline',               -- Statusline framework
  use 'dropbar',              -- Breadcrumbs
  use 'fidget',               -- LSP progress indicator
  use 'gitsigns',             -- Git status in sign column
  use 'mason',                -- LSP/DAP/etc. package manager
  use 'mason-tool-installer', -- Auto-install list of mason binaries
  use 'lsp',                  -- Built-in LSP
  use 'rustaceanvim',         -- rust-analyzer client
  use 'go',                   -- gopls client
  use 'elixir',               -- Elixir LSP setup
  use 'fastaction',           -- Predictable LSP code actions
  use 'java',                 -- Java LSP setup
  use 'typescript',           -- TypeScript LSP client wrapper
  use 'tsc',                  -- TypeScript type checking
  use 'namu',                 -- LSP symbol navigator
  use 'ltex',                 -- LTeX utils
  use 'luasnip',              -- Snippet engine
  use 'blink',                -- Autocompletion
  use 'colorful-menu',        -- Better autocompletion colors
  use 'lazydev',              -- Neovim-aware lua-ls config
  use 'treesitter',           -- Abstract syntax tree
  use 'outline',              -- Code outline sidebar
  use 'neogen',               -- Generate type annotations
  use 'trouble',              -- Nicer list of diagnostics
  use 'telescope',            -- Fuzzy finder
  use 'telescope-cheat',      -- Search cheat.sh with Telescope
  use 'dressing',             -- Improves `vim.ui` interfaces
  use 'noice',                -- Nicer UI features
  use 'lastplace',            -- Restore cursor position
  use 'dial',                 -- Enhanced increment/decrement
  use 'comment',              -- Adds `comment` verb
  use 'rest',                 -- Sending HTTP requests
  use 'dap',                  -- Debugger
  use 'dap-ui',               -- UI for nvim-dap
  use 'overseer',             -- Task runner
  -- { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
  use 'onedark',              -- Colorscheme
  use 'catppuccin',           -- Colorscheme
  use 'refactoring',          -- Refactoring tools
  use 'guess-indent',         -- Guess file's indent level
  use 'yanky',                -- Cycle register history, etc.
  use 'tiny-glimmer',         -- Yank/put animations
  use 'surround',             -- Adds `surround` verb
  use 'eyeliner',             -- Highlight uniques on f/F/t/T
  use 'matchup',              -- Adds additional `%` commands
  use 'ultimate-autopair',    -- Auto-close brackets, etc.
  use 'capslock',             -- Virtual CapsLock
  use 'git-conflict',         -- Git conflict mappings
  use 'vim-textobj',          -- Custom text objects
  use 'vimtex',               -- LaTeX utilities
  use 'ai',                   -- next/previous text objects
  use 'hlsearch',             -- Auto remove search highlights
  use 'markview',             -- Improved Markdown rendering
  use 'helpview',             -- Improved Helpdocs rendering
  use 'markdown-togglecheck', -- Toggle Markdown check marks
  use 'substitute',           -- Replace/exchange operators
  use 'highlighturl',         -- Highlight URLs
  use 'messages',             -- Floating :messages window
  use 'possession',           -- Session manager
  use 'copilot',              -- GitHub Copilot
  use 'diffview',             -- Git diff and file history
  use 'leap',                 -- Move cursor anywhere
  use 'winshift',             -- Improved window movement
  use 'notify',               -- Floating notifications popups
  use 'toggleterm',           -- Toggleable terminal
  use 'term-edit',            -- Better editing in :terminal
  use 'bqf',                  -- Better quickfix
  use 'qf',                   -- Quickfix utilities
  use 'neogit',               -- Git wrapper
  use 'blame',                -- Git blame file
  use 'reloader',             -- Hot reload Neovim config
  use 'template-string',      -- Automatic template string
  use 'csv',                  -- CSV highlighting, etc.
  use 'modicator',            -- Line number mode indicator
  use 'demicolon',            -- Overloaded `;`/`,` keys
  use 'refjump',              -- Jump to next/previous reference
  use 'jsx-element',          -- JSX/TSX text-objects and motions
  use 'unception',            -- Open files in Neovim from terminal
  use 'git-worktree',         -- Manage git worktrees
  use 'octo',                 -- GitHub client
  use 'other',                -- Go to alternate file
  use 'neotest',              -- Testing framework
  use 'package-info',         -- Show package.json versions
  use 'output-panel',         -- LSP logs panel
  use 'typst',                -- Typst highlighting, etc.
  use 'zk',                   -- Zettlekasten (note taking)
  use 'crates',               -- Cargo.toml helper
  use 'gx',                   -- Improved link opening with gx
  use 'various-textobjs',     -- Various text-objects
  use 'icon-picker',          -- Emoji, Nerd Font icons, etc.
  use 'image',                -- ASCII art image viewer
  use 'text-case',            -- Convert between text cases
  use 'ufo',                  -- Improved folds
  use 'statuscol',            -- Custom statuscolumn config
  use 'change-function',      -- Change function arguments order
  use 'ghostty',              -- Ghostty config tools

  -- { 'mawkler/hml.nvim', opts = {} },                     -- H/M/L line number indicators
  { 'kana/vim-niceblock',   event = 'ModeChanged *:[vV]' }, -- Improves visual mode
  { 'wsdjeg/vim-fetch' },                                   -- Edit file at exact line, e.g. `file.lua:123`
  { 'milisims/nvim-luaref', event = 'VeryLazy' },           -- Vim :help reference for lua
  { 'jghauser/mkdir.nvim',  event = 'CmdlineEnter' },       -- Create missing folders on :w
  {
    'milkypostman/vim-togglelist', -- Toggle quickfix window
    event = 'QuickFixCmdPre',
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true },
}

require('lazy').setup({
  spec = plugins,
  install = {
    colorscheme = { 'onedark' },
  },
  performance = {
    rtp = {
      disabled_plugins = { 'netrwPlugin', 'tutor' },
    },
  },
})
