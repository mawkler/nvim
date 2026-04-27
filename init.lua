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

-- Core plugins
local plugins = {
  'folke/lazy.nvim',            -- Package manager
  use 'smart-splits',           -- Better resizing mappings
  use 'indent-blankline',       -- Indent markers
  use 'nvim-web-devicons',      -- File icons
  use 'conform',                -- Autoformatting
  use 'gitsigns',               -- Git status in sign column
  use 'tiny-cmdline',           -- Floating cmdline
  use 'tiny-glimmer',           -- Yank/put animations
  use 'luasnip',                -- Snippet engine
  use 'blink',                  -- Autocompletion
  use 'treesitter',             -- Abstract syntax tree features
  use 'treesitter.textobjects', -- What it sounds like
  use 'dial',                   -- Enhanced increment/decrement
  use 'comment',                -- Adds `comment` verb
  use 'onedark',                -- Colorscheme
  use 'guess-indent',           -- Guess file's indent level
  use 'yanky',                  -- Cycle register history, etc.
  use 'surround',               -- Adds `surround` verb
  use 'eyeliner',               -- Highlight uniques on f/F/t/T
  use 'matchup',                -- Adds additional `%` commands
  use 'ultimate-autopair',      -- Auto-close brackets, etc.
  use 'git-conflict',           -- Git conflict mappings
  use 'ai',                     -- next/previous text objects
  use 'hlsearch',               -- Auto remove search highlights
  use 'substitute',             -- Replace/exchange operators
  use 'codediff',               -- Git diff and file history
  use 'hunk',                   -- For splitting jj changes
  use 'leap',                   -- Move cursor anywhere
  use 'modicator',              -- Line number mode indicator
  use 'demicolon',              -- Overloaded `;`/`,` keys
  use 'various-textobjs',       -- Various text-objects
  use 'ufo',                    -- Improved folds
}

-- Extra plugins
local extra_plugins = {
  use 'eunuch',               -- :Rename, :Delete, etc.
  use 'fugitive',             -- :Git commands
  use 'visualrepeat',         -- Repeat over visual selection
  use 'easy-align',           -- Align characters vertically
  use 'treesj',               -- Multiline split
  use 'autolist',             -- Autocomplete lists
  use 'printer',              -- Print text-object
  use 'cheat',                -- cheat.sh
  use 'alpha',                -- Nicer start screen
  use 'mini-indentscope',     -- Indentation scope
  use 'fzf',                  -- Fuzzy finder
  use 'oil',                  -- Single directory file browser
  use 'barbar',               -- Sexiest buffer tabline
  use 'nvim-tree',            -- File explorer
  use 'neoscroll',            -- Smooth scrolling animations
  use 'feline',               -- Statusline framework
  use 'dropbar',              -- Breadcrumbs
  use 'fidget',               -- LSP progress indicator
  use 'mason',                -- LSP/DAP/etc. package manager
  use 'mason-tool-installer', -- Auto-install list of mason binaries
  use 'lsp',                  -- Built-in LSP
  use 'rustaceanvim',         -- rust-analyzer client
  use 'go',                   -- gopls client
  use 'elixir',               -- Elixir LSP setup
  use 'tiny-code-action',     -- Predictable LSP code actions
  use 'java',                 -- Java LSP setup
  use 'typescript',           -- TypeScript LSP client wrapper
  use 'tsc',                  -- TypeScript type checking
  use 'namu',                 -- LSP symbol navigator
  use 'ltex',                 -- LTeX utils
  use 'colorful-menu',        -- Better autocompletion colors
  use 'lazydev',              -- Neovim-aware lua-ls config
  use 'outline',              -- Code outline sidebar
  use 'neogen',               -- Generate type annotations
  use 'trouble',              -- Nicer list of diagnostics
  use 'telescope',            -- Fuzzy finder
  use 'telescope-cheat',      -- Search cheat.sh with Telescope
  use 'dressing',             -- Improves `vim.ui` interfaces
  use 'lastplace',            -- Restore cursor position
  use 'dap',                  -- Debugger
  use 'dap-ui',               -- UI for nvim-dap
  use 'overseer',             -- Task runner
  use 'catppuccin',           -- Colorscheme
  use 'refactoring',          -- Refactoring tools
  use 'capslock',             -- Virtual CapsLock
  use 'jj-diffconflicts',     -- JJ conflicts tool
  use 'vim-textobj',          -- Custom text objects
  use 'vimtex',               -- LaTeX utilities
  use 'markview',             -- Improved Markdown rendering
  use 'helpview',             -- Improved Helpdocs rendering
  use 'highlighturl',         -- Highlight URLs
  use 'possession',           -- Session manager
  use 'copilot',              -- GitHub Copilot
  use 'leap-spooky',          -- Target text-objects with leap
  use 'winshift',             -- Improved window movement
  use 'notify',               -- Floating notifications popups
  use 'toggleterm',           -- Toggleable terminal
  use 'flatten',              -- Open files in Neovim from terminal
  use 'editable-term',        -- Better editing in :terminal
  use 'bqf',                  -- Better quickfix
  use 'qf',                   -- Quickfix utilities
  use 'neogit',               -- Git wrapper
  use 'blame',                -- Git blame file
  use 'template-string',      -- Automatic template string
  use 'csv',                  -- CSV highlighting, etc.
  use 'refjump',              -- Jump to next/previous reference
  use 'jsx-element',          -- JSX/TSX text-objects and motions
  use 'octo',                 -- GitHub client
  use 'other',                -- Go to alternate file
  use 'neotest',              -- Testing framework
  use 'package-info',         -- Show package.json versions
  use 'output-panel',         -- LSP logs panel
  use 'typst',                -- Typst highlighting, etc.
  use 'zk',                   -- Zettlekasten (note taking)
  use 'crates',               -- Cargo.toml helper
  use 'gx',                   -- Improved link opening with gx
  use 'icon-picker',          -- Emoji, Nerd Font icons, etc.
  use 'image',                -- ASCII art image viewer
  use 'text-case',            -- Convert between text cases
  use 'statuscol',            -- Custom statuscolumn config
  use 'change-function',      -- Change function arguments order
  use 'ghostty',              -- Ghostty config tools
  use 'minty',                -- Color picker
  use 'rustowl',              -- Rust lifetime visualization

  -- Oneliner installs
  { 'kana/vim-niceblock',  event = 'ModeChanged *:[vV]' }, -- Improves visual mode
  { 'wsdjeg/vim-fetch' },                                  -- Edit file at exact line, e.g. `file.lua:123`
  { 'jghauser/mkdir.nvim', event = 'CmdlineEnter' },       -- Create missing folders on :w

  -- Disabled for now
  -- { 'mawkler/hml.nvim', opts = {} },        -- H/M/L line number indicators
  -- { 'jbyuki/one-small-step-for-vimkind' }   -- Lua plugin debug adapter
}

-- If `vim.g.minimal_config` is set, only load the minimal plugins (faster
-- startup time). Useful for CLI tools that invoke `$EDITOR` to do very basic
-- things.
if not vim.g.minimal_config then
  vim.list_extend(plugins, extra_plugins)
end

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

-- Native plugins
require('configs.native-plugins')
